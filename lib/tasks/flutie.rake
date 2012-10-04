require 'fileutils'

def copy_files(source_path, destination_path, directory)
  source, destination = File.join(directory, source_path), File.join(Rails.root, destination_path)
  FileUtils.mkdir_p(destination, :verbose => true) unless File.exist?(destination)
  FileUtils.cp_r(Dir.glob(source), destination, :verbose => true)
end

directory = File.dirname(__FILE__)

namespace :flutie do
  desc 'Install flutie stylesheets into the public/ directory'
  task :install => :environment do
    if Rails.application.config.respond_to?(:assets) && Rails.application.config.assets.enabled
      # No copy is needed when asset pipelining is enabled
      puts "Flutie stylesheets are provided via asset pipelining."
    else
      # Copy the flutie stylesheets into rails_root/public/stylesheets
      copy_files("../../public/stylesheets/*", "/public/stylesheets", directory)

      # Copy the flutie sass stylesheets into rails_root/public/stylesheets/sass/flutie
      copy_files("../../app/assets/stylesheets/*", "/public/stylesheets/sass/flutie", directory)
    end
  end
end
