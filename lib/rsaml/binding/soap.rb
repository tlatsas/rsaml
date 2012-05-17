module RSAML
  module Binding
    # SOAP is a lightweight protocol intended for exchanging structured information in a decentralized,
    # distributed environment [SOAP11]. It uses XML technologies to define an extensible messaging
    # framework providing a message construct that can be exchanged over a variety of underlying protocols.
    # The framework has been designed to be independent of any particular programming model and other
    # implementation specific semantics. Two major design goals for SOAP are simplicity and extensibility.
    # SOAP attempts to meet these goals by omitting, from the messaging framework, features that are often
    # found in distributed systems. Such features include but are not limited to "reliability", "security",
    # "correlation", "routing", and "Message Exchange Patterns" (MEPs).
    #
    # A SOAP message is fundamentally a one-way transmission between SOAP nodes from a SOAP sender
    # to a SOAP receiver, possibly routed through one or more SOAP intermediaries. SOAP messages are
    # expected to be combined by applications to implement more complex interaction patterns ranging from
    # request/response to multiple, back-and-forth "conversational" exchanges [SOAP-PRIMER].
    #
    # SOAP defines an XML message envelope that includes header and body sections, allowing data and
    # control information to be transmitted. SOAP also defines processing rules associated with this envelope
    # and an HTTP binding for SOAP message transmission.
    #
    # The SAML SOAP binding defines how to use SOAP to send and receive SAML requests and responses.
    #
    # Like SAML, SOAP can be used over multiple underlying transports. This binding has protocol-independent
    # aspects, but also calls out the use of SOAP over HTTP as REQUIRED (mandatory to implement).
    #
    # See SAML 2.0 Bindings spec, section 3.2 for more info.
    class SOAP < Base
      URN = 'urn:oasis:names:tc:SAML:2.0:bindings:SOAP'.freeze

      class << self
        def identification
          URN
        end
      end
    end
  end
end
