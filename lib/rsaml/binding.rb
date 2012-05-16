module RSAML #:nodoc:
 # The binding module contains helpers for the SAML 2.0 bindings
  module Binding
  end
end

require 'rsaml/binding/http_redirect'
require 'rsaml/binding/http_post'
require 'rsaml/binding/http_artifact'
require 'rsaml/binding/soap'
require 'rsaml/binding/paos'
require 'rsaml/binding/uri'
