module Setup
  class DataGen

    include Subjects
    include Recipients

    NUM_UPLOADS              = 1000
    MAX_EMAILS_PER_UPLOAD    = 500
    MAX_RECIPIENTS_PER_EMAIL = 20

    def perform
      gen_uploads
      write_json
    end

    private

    def uploads
      @uploads ||= []
    end

    def gen_uploads
      NUM_UPLOADS.times.each { |i| gen_emails }
    end

    def gen_emails
      uploads << { emails: rand_array(MAX_EMAILS_PER_UPLOAD).map { |i| gen_email } }
    end

    def gen_email
      {
        timestamp:  DateTime.new(2016, rand(11)+1, rand(27)+1),
        recipients: rand_array(MAX_RECIPIENTS_PER_EMAIL).map { |i| pick_recipient },
        subject:    pick_subject,
      }
    end

    def rand_array(limit)
      (1..rand(limit)+1).to_a
    end

    def write_json
      File.open("tmp/uploads.json","w") do |f|
        f.write({ uploads: uploads }.to_json)
      end
    end

  end
end