module KMExport
  def self.identity_parser(jsonfile, identity)
    input = IO.open(IO.sysopen(jsonfile))
    time_now = Time.now.to_i.to_s
    output_filename = "#{time_now}_#{identity}_results.json"
    new_filename = "#{time_now}_result.json"
    File.open(output_filename, "w+").close
    File.open(new_filename, "w+").close
    identity_output = IO.open(IO.sysopen(output_filename, "w"), "w")
    data_output = IO.open(IO.sysopen(new_filename, "w"), "w")

    until input.eof?
      row = input.readline
      data = JSON.parse(row)
      if data["_p"] == identity
        identity_output.write(row)
        identity_output.write("\n")
      else
        data_output.write(row)
        data_output.write("\n")
      end
    end

    input.close
    identity_output.close
    data_output.close
    puts "Finished moving actions by #{identity} to: #{output_filename}"
    puts "Created new file with these actions removed: #{new_filename}"

    File.delete(jsonfile)
    puts "Deleted original file: #{jsonfile}"
  end
end
