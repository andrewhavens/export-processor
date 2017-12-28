module KMExport
  def self.json_to_json(filename)
    input = IO.open(IO.sysopen(filename))
    result = []

    until input.eof?
      result << JSON.parse(input.readline)
    end

    new_filename = Time.now.to_i.to_s + "_STANDARD.json"
    output = File.open(new_filename, "w+")

    output.write(JSON.pretty_generate(result))
    output.close

    puts "Created formatted JSON file: #{new_filename}"
  end
end
