# lib/mngm_task/cli.rb
require "optparse"
require_relative "commands/add"
require_relative "commands/list"
require_relative "commands/done"  # done コマンドを追加した場合

module MngmTask
  class CLI
    # エントリポイント
    def self.run(argv = ARGV)
      command = argv.shift

      case command
      when "add"
        run_add(argv)
      when "list"
        run_list(argv)
      when "done"
        run_done(argv)
      else
        puts <<~USAGE
          Usage: mngm_task <command> [options]

          Commands:
            add   TODO を追加する
            list  TODO を一覧表示する
            done  TODO を完了にする
        USAGE
      end
    end

    # --- add コマンド ---

    def self.run_add(argv)
      options = { title: nil }

      OptionParser.new do |opts|
        opts.banner = "Usage: mngm_task add --title TITLE"
        opts.on("-t", "--title TITLE", "TODO のタイトル") { |v| options[:title] = v }
      end.parse!(argv)

      unless options[:title]
        puts "タイトルが必要です (--title で指定してください)"
        return
      end

      Commands::Add.new(title: options[:title]).call
    end

    # --- list コマンド ---

    def self.run_list(argv)
      options = {
        show_created_at: false,
        status: nil,
      }

      OptionParser.new do |opts|
        opts.banner = "Usage: mngm_task list [options]"

        opts.on("--with-time", "作成日時も表示する") do
          options[:show_created_at] = true
        end

        opts.on("--open-only", "未完了の TODO のみ表示する") do
          options[:status] = "open"
        end

        opts.on("--done-only", "完了済みの TODO のみ表示する") do
          options[:status] = "done"
        end
      end.parse!(argv)

      Commands::List.new(
        show_created_at: options[:show_created_at],
        status: options[:status],
      ).call
    end
    # --- done コマンド ---

    def self.run_done(argv)
      options = { id: nil }

      OptionParser.new do |opts|
        opts.banner = "Usage: mngm_task done --id ID"
        opts.on("-i", "--id ID", "完了にする TODO の ID") { |v| options[:id] = v }
      end.parse!(argv)

      unless options[:id]
        puts "ID が必要です (--id で指定してください)"
        return
      end

      Commands::Done.new(id: options[:id]).call
    end
  end
end
