module RSAML
  module Binding
    # In the HTTP Artifact binding, the SAML request, the SAML response, or both are transmitted by reference
    # using a small stand-in called an artifact. A separate, synchronous binding, such as the SAML SOAP
    # binding, is used to exchange the artifact for the actual protocol message using the artifact resolution
    # protocol defined in the SAML assertions and protocols specification [SAMLCore].
    #
    # This binding MAY be composed with the HTTP Redirect binding (see Section 3.4) and the HTTP POST
    # binding (see Section 3.5) to transmit request and response messages in a single protocol exchange using
    # two different bindings.
    #
    # The HTTP Artifact binding is intended for cases in which the SAML requester and responder need to
    # communicate using an HTTP user agent as an intermediary, but the intermediary's limitations preclude or
    # discourage the transmission of an entire message (or message exchange) through it. This may be for
    # technical reasons or because of a reluctance to expose the message content to the intermediary (and if
    # the use of encryption is not practical).
    #
    # Note that because of the need to subsequently resolve the artifact using another synchronous binding,
    # such as SOAP, a direct communication path must exist between the SAML message sender and recipient
    # in the reverse direction of the artifact's transmission (the receiver of the message and artifact must be
    # able to send a <samlp:ArtifactResolve> request back to the artifact issuer). The artifact issuer must
    # also maintain state while the artifact is pending, which has implications for load-balanced environments.
    #
    # See SAML 2.0 Bindings spec, section 3.6 for more info.
    class HTTPArtifact < Base
      URN = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact'.freeze

      class << self
        def identification
          URN
        end
      end
    end
  end
end
