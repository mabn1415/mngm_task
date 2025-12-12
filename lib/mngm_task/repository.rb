# lib/mngm_task/repository.rb

require "yaml"
require "fileutils"
require_relative "todo"

module MngmTask
  class Repository
    DEFAULT_PATH = File.expand_path("../../.mngm_task/todos.yaml", __dir__)

    def initialize(path: DEFAULT_PATH)
      @path = path
      FileUtils.mkdir_p(File.dirname(@path))
    end

    def all
      return [] unless File.exist?(@path)

      str = File.read(@path)
      return [] if str.strip.empty?

      data = YAML.safe_load(str, aliases: true) || []
      data.map { |h| Todo.from_h(h) }
    end
    def save_all(todos)
      data = todos.map(&:to_h)
      File.write(@path, YAML.dump(data))
    end

    def next_id
      (all.map(&:id).max || 0) + 1
    end
  end
end
