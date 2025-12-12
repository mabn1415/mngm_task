# Rakefile

require "bundler/gem_tasks" 

require_relative "lib/mngm_task"

namespace :todo do
  desc "TODO を追加する"
  task :add, [:title] do |_t, args|
    title = args[:title] || ENV["TITLE"]
    abort "タイトルが必要です (rake todo:add['タイトル'] or TITLE=...)" unless title

    MngmTask::CLI.run(["add", "--title", title])
  end

  desc "TODO 一覧を表示する"
  task :list do
    MngmTask::CLI.run(["list"])
  end

  desc "TODO を完了にする"
  task :done, [:id] do |_t, args|
    id = args[:id] || ENV["ID"]
    abort "ID が必要です (rake todo:done[ID] or ID=1 rake todo:done)" unless id

    MngmTask::CLI.run(["done", "--id", id])
  end
end

task default: "todo:list"
