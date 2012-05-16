module RSAML
  module Binding
    # URIs are a protocol-independent means of referring to a resource. This binding is not a general SAML
    # request/response binding, but rather supports the encapsulation of a <samlp:AssertionIDRequest>
    # message with a single <saml:AssertionIDRef> into the resolution of a URI. The result of a successful
    # request is a SAML <saml:Assertion> element (but not a complete SAML response).
    #
    # Like SOAP, URI resolution can occur over multiple underlying transports. This binding has transport-
    # independent aspects, but also calls out the use of HTTP with SSL 3.0 [SSL3] or TLS 1.0 [RFC2246] as
    # REQUIRED (mandatory to implement).
    #
    # See SAML 2.0 Bindings spec, section 3.7 for more info.
    class URI
      URN = 'urn:oasis:names:tc:SAML:2.0:bindings:URI'.freeze

      def self.identification
        URN
      end
    end
  end
end
