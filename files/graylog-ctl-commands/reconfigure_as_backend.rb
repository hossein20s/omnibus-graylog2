add_command 'reconfigure-as-backend', 'Run Graylog server and Elasticsearch on this node', 1 do |cmd_name|
  require 'fileutils'
  require 'json'

  if true
    existing_services ||= Hash.new
    if File.exists?("/etc/graylog/graylog-services.json")
      existing_services = JSON.parse(File.read("/etc/graylog/graylog-services.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
      existing_services['etcd']            = Hash.new
      existing_services['nginx']           = Hash.new
      existing_services['mongodb']         = Hash.new
      existing_services['elasticsearch']   = Hash.new
      existing_services['graylog_server']  = Hash.new
      existing_services['graylog_web']     = Hash.new
    end

    existing_services['etcd']['enabled']            = true
    existing_services['nginx']['enabled']           = false
    existing_services['mongodb']['enabled']         = true
    existing_services['elasticsearch']['enabled']   = true
    existing_services['graylog_server']['enabled']  = true
    existing_services['graylog_web']['enabled']     = false

    File.open("/etc/graylog/graylog-services.json","w") do |services|
      services.write(JSON.pretty_generate(existing_services))
    end

    reconfigure
  else
    puts "Usage: #{cmd_name}"
  end
end
