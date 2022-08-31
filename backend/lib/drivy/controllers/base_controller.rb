# frozen_string_literal: true

module Drivy
  class BaseController
    class << self
      private

      def process_files(input_path, output_path)
        data = yield(JSON.parse(File.read(input_path)))

        File.write(output_path, data.to_json)
        puts 'SUCCESSFULLY FINISHED'
        puts data
        puts "RESULTS FILE: #{output_path}"
      rescue Errno::ENOENT, JSON::ParserError, Date::Error, BaseError => e
        puts 'FAILED'
        puts "#{e.class} #{e.message}"
      end
    end

    private_class_method :new
  end
end
