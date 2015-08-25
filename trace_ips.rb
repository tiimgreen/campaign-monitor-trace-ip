require './lib/ip_tracer'

emails = [
  'test1@test.com',
  'test2@test.com',
  'test3@test.com',
  'test4@test.com'
]

tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"])
tracer.trace_locations(emails)
