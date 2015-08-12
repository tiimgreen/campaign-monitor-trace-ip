class IPTracer
  attr_accessor :api_key, :list_id, :file, :database

  def initialize(api_key, list_id, file = './records.csv', database = './GeoLiteCity.dat')
    @api_key, @list_id, @file, @database = api_key, list_id, file, database
  end

  # Traces the location of subscribers given an array of their emails
  # and prints them to a file specified
  #
  # @params [emails:Array]
  # @return [String]
  #
  # Example
  #
  #   tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"])
  #   tracer.trace_locations([
  #     'example1@company.com',
  #     'example2@company.com'
  #   ])
  #
  def trace_locations(emails)
    write_to_csv('w', ['email', 'ip_address', 'country', 'city'])

    emails.each do |email|
      subscriber = CreateSend::Subscriber.new({ api_key: @api_key }, @list_id, email)
      next if subscriber.history[0].Actions.length == 0
      write_subscriber_data_to_file(subscriber)
    end

    puts "All locations saved to #{@file}".green.bold
  end

  private

    # Writes to @file
    #
    # @params [mode:String, contents:Array]
    # @return [Integer]
    #
    # Example
    #
    #   write_to_csv('w', headers = ['email', 'ip_address', 'country', 'city'])
    #   write_to_csv('a', user_record)
    #
    def write_to_csv(mode, contents)
      File.open(@file, mode) { |file| file.write("#{contents.join(',')}\n") }
    end

    # Returns geographical data about the IP address
    #
    # @params [ip_address:String]
    # @return [GeoIP::City]
    #
    # Example
    #
    #   lookup('192.168.10.10')
    #
    def lookup(ip_address)
      GeoIP.new(@database).city(ip_address)
    end

    # Find the IP address of the Subscriber passed
    #
    # @params [subscriber:CreateSend::Subscriber]
    # @return [String]
    #
    # Example
    #
    #   trace_ip_of_subscriber(
    #     CreateSend::Subscriber.new({ api_key: @api_key }, @list_id, email)
    #   )
    #   => '192.168.10.10'
    #
    def trace_ip_of_subscriber(subscriber)
      ip_addresses = []
      subscriber.history[0].Actions.each { |action| ip_addresses << action.IPAddress }
      find_mode_ip(ip_addresses)
    end

    # Find the most common IP address of all the ones registered to that Subscriber
    #
    # @params [ip_address:String]
    # @return [String]
    #
    # Example
    #
    #   find_mode_ip([
    #     '192.168.10.10',
    #     '192.168.10.10',
    #     '192.168.10.9'
    #   ])
    #    => '192.168.10.10'
    #
    def find_mode_ip(ip_addresses)
      ip_addresses.max_by { |x| ip_addresses.count(x) }
    end

    # Organises the subscriber data and writes to file
    #
    # @params [subscriber:CreateSend::Subscriber]
    # @return [Integer]
    #
    def write_subscriber_data_to_file(subscriber)
      ip_address = trace_ip_of_subscriber(subscriber)
      location = lookup(ip_address)
      user_record = [subscriber.email_address, ip_address, location.country_name, location.city_name]
      write_to_csv('a', user_record)
    end
end
