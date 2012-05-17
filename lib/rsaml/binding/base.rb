module RSAML
  module Binding
    # Common functionality shared amongst specific bindings implementations.
    class Base
      class << self
        # Some bindings require an encoding before sending a SAML protocol message.
        # Override this to provide the encoding mechanism required.
        # By default this returns the input as given.
        #
        # Important : If this gets overriden, decode should be too,
        # with the general rule of decode(encode(original)) == original.
        def encode(xml)
          xml
        end

        # Some bindings receive an encoded SAML protocol message.
        # Override this to provide the decode mechanism required.
        # By default this returns the input as given.
        #
        # Important : If this gets overriden, encode should be too,
        # with the general rule of decode(encode(original)) == original.
        def decode(xml)
          xml
        end

        # Initializes a new RSAML::Protocol::AuthnRequest after decoding the given xml.
        def authn_request(xml)
          Protocol::AuthnRequest.from_xml(decode(xml))
        end
      end
    end
  end
end
