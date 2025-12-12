# lib/mngm_task/commands/list.rb
require_relative "../repository"

module MngmTask
  module Commands
    class List
      def initialize(repo: Repository.new, show_created_at: false, status: nil)
        @repo = repo
        @show_created_at = show_created_at
        @status = status # nil / "open" / "done"
      end

      def call
        todos = @repo.all

        # status で絞り込み
        todos = filter_by_status(todos)

        if todos.empty?
          puts "TODO はありません ✅"
          return
        end

        todos.each do |t|
          mark = t.done? ? "✔" : " "
          line = "[#{mark}] (#{t.id}) #{t.title}"
          if @show_created_at
            line += " - #{t.created_at.strftime('%Y-%m-%d %H:%M')}"
          end
          puts line
        end
      end

      private

      def filter_by_status(todos)
        case @status
        when "open"
          todos.reject(&:done?)
        when "done"
          todos.select(&:done?)
        else
          todos
        end
      end
    end
  end
end
