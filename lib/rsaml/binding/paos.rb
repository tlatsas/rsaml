module RSAML
  module Binding
    # Reverse SOAP (PAOS)
    #
    # The reverse SOAP binding is a mechanism by which an HTTP requester can advertise the ability to act as
    # a SOAP responder or a SOAP intermediary to a SAML requester. The HTTP requester is able to support
    # a pattern where a SAML request is sent to it in a SOAP envelope in an HTTP response from the SAML
    # requester, and the HTTP requester responds with a SAML response in a SOAP envelope in a subsequent
    # HTTP request. This message exchange pattern supports the use case defined in the ECP SSO profile
    # (described in the SAML profiles specification [SAMLProfile]), in which the HTTP requester is an
    # intermediary in an authentication exchange.
    #
    # See SAML 2.0 Bindings spec, section 3.3 for more info.
    class PAOS < Base
      URN = 'urn:oasis:names:tc:SAML:2.0:bindings:PAOS'.freeze

      class << self
        def identification
          URN
        end
      end
    end
  end
end
