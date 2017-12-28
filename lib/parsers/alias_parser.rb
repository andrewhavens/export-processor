module KMExport
  def self.alias_parser(jsonfile)
    input = IO.open(IO.sysopen(jsonfile))
    time_now = Time.now.to_i.to_s
    alias_filename = "#{time_now}_aliases.json"
    new_filename = "#{time_now}_result.json"
    File.open(alias_filename, "w+").close
    File.open(new_filename, "w+").close
    alias_output = IO.open(IO.sysopen(alias_filename, "w"), "w")
    data_output = IO.open(IO.sysopen(new_filename, "w"), "w")

    until input.eof?
      original_line = input.readline
      line = JSON.parse(original_line)
      if line["_p2"]
        alias_output.write(original_line)
        alias_output.write("\n")
      else
        data_output.write(original_line)
        data_output.write("\n")
      end
    end

    input.close
    alias_output.close
    data_output.close
    puts "Finished moving aliases to: #{alias_filename}"
    puts "Created new file with aliases removed: #{new_filename}"

    File.delete(jsonfile)
    puts "Deleted original file: #{jsonfile}"
  end
end
