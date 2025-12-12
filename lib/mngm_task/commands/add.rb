# lib/mngm_task/commands/add.rb
require_relative "../repository"

module MngmTask
  module Commands
    class Add
      def initialize(title:, repo: Repository.new)
        @title = title
        @repo  = repo
      end

      def call
        todos = @repo.all
        id    = @repo.next_id
        todo  = Todo.new(id: id, title: @title)
        todos << todo
        @repo.save_all(todos)
        puts "[#{id}] #{@title} を追加しました"
      end
    end
  end
end
