# mngm_task.gemspec
require_relative "lib/mngm_task/version"

Gem::Specification.new do |spec|
  spec.name          = "mngm_task"
  spec.version       = MngmTask::VERSION
  spec.summary       = "Simple terminal TODO manager"
  spec.description   = "Rake + CLI based TODO manager for managing small personal tasks."
  spec.authors       = ["Masaki"]
  spec.email         = ["example@example.com"]  # 適当に

  spec.license       = "MIT"

  spec.require_paths = ["lib"]

  # gem に含めるファイル
  spec.files = Dir[
    "lib/**/*.rb",
    "exe/*",
    "README*",
    "LICENSE*",
    "Rakefile",
    "mngm_task.gemspec"
  ]

  # 実行ファイル
  spec.bindir      = "exe"
  spec.executables = ["mngm_task"]

  # 依存関係（必要があれば）
  # spec.add_dependency "some-gem"
end
