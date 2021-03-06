# Campaign Monitor Trace IPs

Find the geographic location and IP address of subscribers to a Campaign Monitor list.

## How to use

### Setup

```bash
$ bundle
$ API_KEY={{api_key}} LIST_ID={{list_id}} ruby trace_ips.rb
```

### Customisation

Initialize a new IPTracer object with the `api_key` and `list_id` as parameters. You can also specify the file to write to (defaults to `'./records.csv'`) and the database used to lookup the IPs (defaults to `'./GeoLiteCity.dat'`) as optional 3rd and 4th parameters respectively.

Call `#trace_locations` on the new object as pass an array of Emails. The results will be written to the CSV file with the headers `email,ip_address,country,city`.

```ruby
emails = [
  'test1@test.com',
  'test2@test.com',
  'test3@test.com',
  'test4@test.com'
]

tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"], './users.csv', './GeoIP.dat')
tracer.trace_locations(emails)
```
