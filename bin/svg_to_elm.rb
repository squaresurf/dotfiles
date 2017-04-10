#!/usr/bin/env ruby

require 'nokogiri'

raise 'You must pass the svg to STDIN' if STDIN.tty?

QUALIFY_NAME = ARGV.shift
QUALIFY = ARGV.to_a

svg = Nokogiri::XML(STDIN)

def elem_name(elem)
  name = elem.name
  QUALIFY.include?(name) ? "#{QUALIFY_NAME}.#{name}" : name
end

def attr_name(attr)
  attr.gsub(/-(.)/) { Regexp.last_match[1].upcase }
end

def get_attrs(elem)
  elem.attributes.map do |_, attr|
    %(#{attr_name attr.name} "#{attr.value}")
  end
end

def get_children(elem)
  elem.children.map { |child| elem2elm child }.compact
end

def elem2elm(elem)
  attrs = get_attrs(elem).join(',')
  children = get_children(elem).join(',')

  return if attrs.empty? && children.empty?

  "#{elem_name elem} [#{attrs}] [#{children}]"
end

puts elem2elm(svg.child)
