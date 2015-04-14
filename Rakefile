# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Samson::Application.load_tasks

Rake::Task["default"].clear

Rails::TestTask.new(:default) do |t|
  t.pattern = "{test,plugins/*/test}/**/*_test.rb"
end

namespace :plugins do
  Rails::TestTask.new(:test) do |t|
    t.pattern = "plugins/*/test/**/*_test.rb"
  end
end

namespace :test do
  task js: :environment do
    with_tmp_karma_config do |config|
      sh "./node_modules/karma/bin/karma start #{config} --single-run"
    end
  end

  private

  def with_tmp_karma_config
    Tempfile.open('karma.js') do |f|
      f.write build_karma_config(karma_test_files)
      f.flush
      yield f.path
    end
  end

  def karma_test_files
    [
      resolve_asset('vis.js'),
      'vendor/assets/javascripts/angular.min.js',
      'vendor/assets/javascripts/angular-mocks.js',
      'vendor/assets/javascripts/underscore.min.js',
      'test/angular/test_helper.js',
      'app/assets/javascripts/app.js',
      'app/assets/javascripts/controllers/**/*.js',
      'app/assets/javascripts/directives/**/*.js',
      'app/assets/javascripts/timeline.js',
      'test/angular/**/*_spec.js'
    ]
  end

  def resolve_asset(file)
    Rails.application.assets.find_asset(file).to_a.first.pathname.to_s
  end

  def build_karma_config(files)
    config = File.read('test/karma.conf.js')
    {
      "INSERT_FILES_VIA_RAKE" => "\"#{files.join("\",\n\"")}\"",
      "INSERT_BASE_PATH_VIA_RAKE" => Bundler.root.to_s,
    }.each { |key, value| config.gsub!(key, value) || raise("#{key} not found") }
    config
  end
end
