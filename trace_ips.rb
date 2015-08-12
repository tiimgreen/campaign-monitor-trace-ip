require 'createsend'
require 'geoip'
require 'toc'
require './lib/ip_tracer'

emails = [
  'tom@parall.ax',
  'lawrence@parall.ax'
]

tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"])
tracer.trace_locations(emails)
