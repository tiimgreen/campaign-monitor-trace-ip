# Campaign Monitor Trace IPs

Trace the IP addresses of subscribers given their email address


### How to use

Simply initialize a new IPTracer object with the `api_key` and `list_id` as parameters. You can also specify the file to write to (defaults to `'./records.csv'`) and the database used to lookup the IPs (defaults to `'./GeoLiteCity.dat'`) as 3rd and 4th parameters respectively.

```ruby
tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"], './users', './GeoIP.dat')
tracer.trace_locations(emails)
```
