# frozen_string_literal: true

class FileReader
  def self.read(path)
    File.read path
  rescue Errno::ENOENT => e
    puts "File not found: #{e}"
  end
end
