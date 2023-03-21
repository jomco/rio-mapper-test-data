def replace(path)
  if File.file?(path)
    # Replace FOO with BAR in file contents
    text = File.read(path)
    new_contents = text.gsub(ARGV[0], ARGV[0].succ)
    File.open(path, "w") { |file| file.puts new_contents }

    # Replace FOO with BAR in file names
    new_path = path.gsub(ARGV[0], ARGV[0].succ)
    File.rename(path, new_path) unless new_path == path
  elsif File.directory?(path)
    # Replace FOO with BAR in folder names
    new_path = path.gsub(ARGV[0], ARGV[0].succ)
    File.rename(path, new_path) unless new_path == path

    # Recursively replace FOO with BAR in folder contents
    Dir.glob("#{new_path}/*") do |subpath|
      replace(subpath)
    end
  end
end

replace(".")
