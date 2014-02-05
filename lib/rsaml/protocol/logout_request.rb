module RSAML #:nodoc:
  module Protocol #:nodoc:
    class LogoutRequest < Request
      attr_accessor :name
      attr_accessor :destination

      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {}
        attributes['Destination'] = destination unless destination.nil?
        attributes = add_xmlns(attributes)
        xml.tag!('samlp:LogoutRequest', attributes) {
          xml << name.to_xml unless name.nil?
          xml << issuer.to_xml unless issuer.nil?
        }
      end

      def self.from_xml(element)
        element = REXML::Document.new(element).root if element.is_a?(String)
        self.new.tap { |request|
          request.id = element.attribute('ID').value if element.attribute('ID')
          request.version = element.attribute('Version').value if element.attribute('Version')
          request.issue_instant = Time.parse(element.attribute('IssueInstant').value).utc if element.attribute('IssueInstant')
          request.destination = element.attribute('Destination').value if element.attribute('Destination')

          request.assertion_consumer_service_url = element.attribute('AssertionConsumerServiceURL').value if element.attribute('AssertionConsumerServiceURL')

          if (subject = element.get_elements('saml:Issuer').first)
            request.issuer = Identifier::Issuer.from_xml(subject)
          end

          if (subject = element.get_elements('saml:NameID').first || element.get_elements('NameID').first)
            request.name = Identifier::Name.from_xml(subject)
          end
        }
      end
    end
  end
end
