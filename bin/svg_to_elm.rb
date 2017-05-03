#!/usr/bin/env ruby

require 'nokogiri'

raise 'You must pass the svg to STDIN' if STDIN.tty?

svg = Nokogiri::XML(STDIN)

SPECIAL_NAMES = %w(text)
SPECIAL_ATTRS = %w(in type)

puts "  -- BEWARE OF DEFS IDS!!!"

def namespace_name(ns, name)
  return name unless ns&.prefix
  name[0] = name[0].upcase
  ns.prefix + name
end

def elem_name(elem)
  name = elem.name
  name = "#{name}_" if SPECIAL_NAMES.include?(name)
  "Svg.#{namespace_name(elem.namespace, name)}"
end

def attr_name(attr)
  attr = "#{attr}_" if SPECIAL_ATTRS.include?(attr)
  attr.gsub(/-(.)/) { Regexp.last_match[1].upcase }
end

def attrs(elem)
  elem.attributes.map do |_, attr|
    name = namespace_name(attr.namespace, attr_name(attr.name))
    %(Svg.Attributes.#{name} "#{attr.value}")
  end
end

def children(elem)
  elem.children.map { |child| elem2elm child }.compact
end

def elem2elm(elem)
  return %(Svg.text "#{elem.to_s}") if elem.class == Nokogiri::XML::Text && !elem.to_s.strip.empty?

  line_end = "\n  "
  attrs = attrs(elem).join(",#{line_end}")
  children = children(elem).join(",#{line_end}")

  return if attrs.empty? && children.empty?

  "  #{elem_name elem}#{line_end}[#{line_end}#{attrs}#{line_end}]#{line_end}[#{line_end}#{children}#{line_end}]"
end

puts elem2elm(svg.child)
