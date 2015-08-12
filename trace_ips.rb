require 'createsend'
require 'geoip'
require 'toc'
require './lib/ip_tracer'

emails = [
  'lawrence@parall.ax',
  'tom@parall.ax',
  'lawrence@parall.ax'
]

tracer = IPTracer.new(ENV["API_KEY"], ENV["LIST_ID"])
tracer.trace_locations(emails)
