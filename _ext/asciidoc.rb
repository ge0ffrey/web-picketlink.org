# dependencies for asciidoc support
require 'tilt'
require 'haml'
require 'asciidoctor'

# hack to add asciidoc support in HAML
# remove once haml_contrib has accepted the asciidoc registration patch
# :asciidoc
#   some block content
#
# :asciidoc
#   :doctype: inline
#   some inline content
#
if !Haml::Filters.constants.include?('AsciiDoc')
  Haml::Filters.register_tilt_filter 'AsciiDoc'
  Haml::Filters::AsciiDoc.options[:safe] = :safe
  Haml::Filters::AsciiDoc.options[:attributes] ||= {}
  Haml::Filters::AsciiDoc.options[:attributes]['notitle!'] = ''
  # copy attributes from site.yml
  attributes = site.asciidoctor[:attributes].each do |key, value|
    Haml::Filters::AsciiDoc.options[:attributes][key] = value
  end
end
