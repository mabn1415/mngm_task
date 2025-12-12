# lib/mngm_task/todo.rb
require "time"

module MngmTask
  class Todo
    attr_reader :id, :title, :status, :created_at

    def initialize(id:, title:, status: "open", created_at: Time.now)
      @id = id
      @title = title
      @status = status
      @created_at = created_at
    end

    def done?
      status == "done"
    end

    def mark_done
      Todo.new(
        id: id,
        title: title,
        status: "done",
        created_at: created_at
      )
    end

    def to_h
      {
        "id" => id,
        "title" => title,
        "status" => status,
        "created_at" => created_at.iso8601
      }
    end

    def self.from_h(hash)
      new(
        id: hash["id"],
        title: hash["title"],
        status: hash["status"],
        created_at: Time.parse(hash["created_at"])
      )
    end
  end
end
