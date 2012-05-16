module RSAML
  module Binding
    # The HTTP Redirect binding defines a mechanism by which SAML protocol messages can be transmitted
    # within URL parameters. Permissible URL length is theoretically infinite, but unpredictably limited in
    # practice. Therefore, specialized encodings are needed to carry XML messages on a URL, and larger or
    # more complex message content can be sent using the HTTP POST or Artifact bindings.
    #
    # This binding MAY be composed with the HTTP POST binding (see Section 3.5) and the HTTP Artifact
    # binding (see Section 3.6) to transmit request and response messages in a single protocol exchange using
    # two different bindings.
    #
    # This binding involves the use of a message encoding. While the definition of this binding includes the
    # definition of one particular message encoding, others MAY be defined and used.
    #
    # The HTTP Redirect binding is intended for cases in which the SAML requester and responder need to
    # communicate using an HTTP user agent (as defined in HTTP 1.1 [RFC2616]) as an intermediary. This
    # may be necessary, for example, if the communicating parties do not share a direct path of communication.
    # It may also be needed if the responder requires an interaction with the user agent in order to fulfill the
    # request, such as when the user agent must authenticate to it.
    #
    # Note that some HTTP user agents may have the capacity to play a more active role in the protocol
    # exchange and may support other bindings that use HTTP, such as the SOAP and Reverse SOAP
    # bindings. This binding assumes nothing apart from the capabilities of a common web browser.
    #
    # See SAML 2.0 Bindings spec, section 3.4 for more info.
    class HTTPRedirect
      URN = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect'.freeze

      def self.identification
        URN
      end
    end
  end
end
