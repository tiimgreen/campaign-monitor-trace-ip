# Campaign Monitor Trace IPs

Trace the IP addresses of subscribers given their email address.


## How to use

### Setup

```bash
$ bundle
$ ruby trace_ips.rb
```

### Customisation

Initialize a new IPTracer object with the `api_key` and `list_id` as parameters. You can also specify the file to write to (defaults to `'./records.csv'`) and the database used to lookup the IPs (defaults to `'./GeoLiteCity.dat'`) as optional 3rd and 4th parameters respectively.

Call `#trace_locations` on the new object as pass an array of Emails. The results will be written to the file.

```ruby
emails = [
  'lawrence@parall.ax',
  'tom@parall.ax',
  'lawrence@parall.ax'
]

tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"], './users', './GeoIP.dat')
tracer.trace_locations(emails)
```
