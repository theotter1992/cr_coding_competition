task :perform_uploads => :environment do

  uploads = JSON.parse(File.read('uploads.json')).with_indifferent_access[:uploads]

  start_time = Time.now
  uploads.each do |upload|
    HTTParty.post("http://localhost:3000/api/upload_emails", body: upload.to_json)
  end
  
  diff = Time.now - start_time

  if diff > 0
    puts "time: #{sprintf('%.2f', diff)}s || Not bad but could be better ;)"
  else
    puts "You're hired!"
  end
end