# lib/mngm_task/commands/done.rb
require_relative "../repository"

module MngmTask
  module Commands
    class Done
      def initialize(id:, repo: Repository.new)
        @id   = Integer(id)
        @repo = repo
      end

      def call
        todos = @repo.all
        todo  = todos.find { |t| t.id == @id }

        unless todo
          puts "ID=#{@id} の TODO は見つかりませんでした"
          return
        end

        updated = todo.mark_done
        new_todos = todos.map { |t| t.id == @id ? updated : t }

        @repo.save_all(new_todos)
        puts "[#{@id}] #{todo.title} を完了にしました"
      end
    end
  end
end
