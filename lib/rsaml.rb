if RUBY_VERSION =~ /1\.8/
  $KCODE = 'UTF-8'
end

module RSAML
  def saml_namespaces
    {
      'saml' => 'urn:oasis:names:tc:SAML:2.0:assertion',
      'samlp' => 'urn:oasis:names:tc:SAML:2.0:protocol',
      'ds' => 'http://www.w3.org/2000/09/xmldsig#',
      'xenc' => 'http://www.w3.org/2001/04/xmlenc#',
      'xs' => 'http://www.w3.org/2001/XMLSchema',
      'xsi' => 'http://www.w3.org/2001/XMLSchema-instance'
    }
  end
end

require 'rubygems'
require 'uuid'
require 'builder'
begin
  require 'active_support'
  require 'active_support/time'
  require 'active_support/time_with_zone'
  require 'active_support/core_ext'
rescue LoadError
  require 'activesupport'
end

require "rexml/document"

$:.unshift(File.dirname(__FILE__))

require 'xml_sig'
require 'xml_enc'

require 'rsaml/ext/string'

require 'rsaml/encrypted'
require 'rsaml/validatable'
require 'rsaml/errors'

require 'rsaml/action'
require 'rsaml/action_namespace'
require 'rsaml/advice'
require 'rsaml/assertion'
require 'rsaml/attribute'
require 'rsaml/attribute_value'
require 'rsaml/audience'
require 'rsaml/authentication_context'
require 'rsaml/condition'
require 'rsaml/conditions'
require 'rsaml/evidence'
require 'rsaml/identifier'
require 'rsaml/proxy_restriction'
require 'rsaml/statement'
require 'rsaml/subject'
require 'rsaml/subject_confirmation'
require 'rsaml/subject_confirmation_data'
require 'rsaml/subject_locality'

require 'rsaml/protocol'

require 'rsaml/binding'

require 'rsaml/parser'
