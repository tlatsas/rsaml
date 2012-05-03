module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Tailors the name identifier in the subjects of assertions resulting from an authentication request.
    class NameIdPolicy
      # Specifies the URI reference corresponding to a name identifier format.
      # See section 8.3 of the SAML Core 2.0 specific for allowed formats.
      attr_accessor :format
      
      # Optionally specifies that the assertion subject's identifier be returned (or created) in the namespace of 
      # a service provider other than the requester, or in the namespace of an affiliation group of service 
      # providers.
      attr_accessor :sp_name_qualifier
      
      # A Boolean value used to indicate whether the identity provider is allowed, in the course of fulfilling the 
      # request, to create a new identifier to represent the principal. Defaults to "false". When "false", the 
      # requester constrains the identity provider to only issue an assertion to it if an acceptable identifier for 
      # the principal has already been established. Note that this does not prevent the identity provider from 
      # creating such identifiers outside the context of this specific request (for example, in advance for a 
      # large number of principals).
      attr_accessor :allow_create

      # True if `allow_create` is explicitly `true`, otherwise `false` as per the spec
      # definition default value.
      def allow_create?
        allow_create == true
      end
      
      # Construct an XML fragment representing the name id policy
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {}
        attributes['Format'] = format unless format.nil?
        attributes['SPNameQualifier'] = sp_name_qualifier unless sp_name_qualifier.nil?
        attributes['AllowCreate'] = allow_create unless allow_create.nil?
        xml.tag!('samlp:NameIDPolicy', attributes)
      end

      # Construct an NameIdPolicy instance from the given XML Element or fragment.
      def self.from_xml(element)
        element = REXML::Document.new(element).root if element.is_a?(String)
        self.new.tap { |policy|
          policy.format = element.attribute('Format').value if element.attribute('Format')
          policy.sp_name_qualifier = element.attribute('SPNameQualifier').value if element.attribute('SPNameQualifier')
          if element.attribute('AllowCreate')
            policy.allow_create = element.attribute('AllowCreate').value == 'true'
          end
        }
      end
    end
  end
end
