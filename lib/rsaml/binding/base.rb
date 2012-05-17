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

        # Generates a valid XML document for the given RSAML::Protocol::Message
        # and encodes it according the actual binding implementation.
        #
        # Accepted options is :pretty to pretty print the generated XML (defaults to true).
        def message_data(message, options = {})
          raise ArgumentError.new('message should be kind of RSAML::Protocol::Message') unless message.kind_of? RSAML::Protocol::Message
          encode(generate_message_xml(message, options))
        end

        #########
        protected
        #########

        def generate_message_xml(message, options = {})
          options = options.reverse_merge(:pretty => true)

          xml = Builder::XmlMarkup.new
          xml.instruct!

          if options[:pretty]
            formatter = REXML::Formatters::Pretty.new(4)
            pretty_xml = ""
            formatter.write(REXML::Document.new(message.to_xml(xml)), pretty_xml)
            pretty_xml
          else
            message.to_xml(xml)
          end
        end
      end

      # Accessor to the actual class method.
      def identification
        self.class.identification
      end
    end
  end
end
