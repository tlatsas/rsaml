module RSAML #:nodoc:
  module Protocol #:nodoc:
    # To request that an identity provider issue an assertion with an authentication statement, a presenter 
    # authenticates to that identity provider (or relies on an existing security context) and sends it an 
    # <AuthnRequest> message that describes the properties that the resulting assertion needs to have to 
    # satisfy its purpose. Among these properties may be information that relates to the content of the assertion 
    # and/or information that relates to how the resulting <Response> message should be delivered to the 
    # requester. The process of authentication of the presenter may take place before, during, or after the initial 
    # delivery of the <AuthnRequest> message. 
    #
    # The requester might not be the same as the presenter of the request if, for example, the requester is a 
    # relying party that intends to use the resulting assertion to authenticate or authorize the requested subject 
    # so that the relying party can decide whether to provide a service.
    class AuthnRequest < Request
      # Specifies the requested subject of the resulting assertion(s).
      attr_accessor :subject

      # Specifies constraints on the name identifier to be used to represent the requested subject. If omitted,
      # then any type of identifier supported by the identity provider for the requested subject can be used,
      # constrained by any relevant deployment-specific policies, with respect to privacy, for example.
      attr_accessor :name_id_policy

      # Specifies the SAML conditions the requester expects to limit the validity and/or use of the resulting
      # assertion(s). The responder MAY modify or supplement this set as it deems necessary. The
      # information in this element is used as input to the process of constructing the assertion, rather than as
      # conditions on the use of the request itself.
      attr_accessor :conditions

      # Specifies the requirements, if any, that the requester places on the authentication context that applies
      # to the responding provider's authentication of the presenter.
      attr_accessor :requested_authn_context

      # Specifies a set of identity providers trusted by the requester to authenticate the presenter, as well as
      # limitations and context related to proxying of the <Au message to subsequent identity providers by the
      # responder.
      attr_accessor :scoping

      # A Boolean value. If "true", the identity provider MUST authenticate the presenter directly rather than
      # rely on a previous security context. If a value is not provided, the default is "false". However, if both
      # ForceAuthn and IsPassive are "true", the identity provider MUST NOT freshly authenticate the
      # presenter unless the constraints of IsPassive can be met.
      attr_accessor :force_authn

      # Returns only a boolean value if such exists in `force_authn`, otherwise falls back to the per SAML spec
      # default "false".
      def force_authn?
        force_authn == true
      end

      # A Boolean value. If "true", the identity provider and the user agent itself MUST NOT visibly take control 
      # of the user interface from the requester and interact with the presenter in a noticeable fashion. If a 
      # value is not provided, the default is "false".
      attr_accessor :is_passive

      # Returns only a boolean value if such exists in `is_passive`, otherwise falls back to the per SAML spec
      # default "false".
      def passive?
        is_passive == true
      end

      attr_accessor :assertion_consumer_service_index

      attr_accessor :assertion_consumer_service_url

      # A URI reference that identifies a SAML protocol binding to be used when returning the response message.
      attr_accessor :protocol_binding

      # Indirectly identifies information associated with the requester describing the SAML attributes the
      # requester desires or requires to be supplied by the identity provider in the <Response> message. The
      # identity provider MUST have a trusted means to map the index value in the attribute to information
      # associated with the requester.
      attr_accessor :attribute_consuming_service_url

      # Specifies the human-readable name of the requester for use by the presenter's user agent or the
      # identity provider
      attr_accessor :provider_name

      # Validate the authentication request.
      def validate
        raise ValidationError, "Conditions must be of type Conditions" if conditions && !conditions.is_a?(Conditions)
      end

      # Construct an XML fragment representing the authentication request
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {}
        attributes['ForceAuthn'] = force_authn unless force_authn.nil?
        attributes['IsPassive'] = is_passive unless is_passive.nil?
        # TODO implement assertion consumer service index
        # TODO implement assertion consumer service URL
        attributes['ProtocolBinding'] = protocol_binding unless protocol_binding.nil?
        attributes['AttributeConsumingServiceURL'] = attribute_consuming_service_url unless attribute_consuming_service_url.nil?
        attributes['ProviderName'] = provider_name unless provider_name.nil?
        attributes = add_xmlns(attributes)
        xml.tag!('samlp:AuthnRequest', attributes) {
          xml << subject.to_xml unless subject.nil?
          xml << name_id_policy.to_xml unless name_id_policy.nil?
          xml << conditions.to_xml unless conditions.nil?
          xml << requested_authn_context unless requested_authn_context.nil?
          xml << scoping.to_xml unless scoping.nil?
        }
      end

      # Construct an AuthnRequest instance from the given XML Element or fragment.
      def self.from_xml(element)
        element = REXML::Document.new(element).root if element.is_a?(String)
        self.new.tap { |request|
          request.id = element.attribute('ID').value if element.attribute('ID')
          request.version = element.attribute('Version').value if element.attribute('Version')
          request.issue_instant = Time.parse(element.attribute('IssueInstant').value).utc if element.attribute('IssueInstant')
          request.destination = element.attribute('Destination').value if element.attribute('Destination')
          request.consent = element.attribute('Consent').value if element.attribute('Consent')

          request.protocol_binding = element.attribute('ProtocolBinding').value if element.attribute('ProtocolBinding')
          request.provider_name = element.attribute('ProviderName').value if element.attribute('ProviderName')
          request.assertion_consumer_service_url = element.attribute('AssertionConsumerServiceURL').value if element.attribute('AssertionConsumerServiceURL')

          request.force_authn = element.attribute('ForceAuthn').value == 'true' if element.attribute('ForceAuthn')
          request.is_passive = element.attribute('IsPassive').value == 'true' if element.attribute('IsPassive')

          if (subject = element.get_elements('saml:Issuer').first)
            request.issuer = Identifier::Issuer.from_xml(subject)
          end

          if (subject = element.get_elements('samlp:NameIDPolicy').first || element.get_elements('NameIDPolicy').first)
            request.name_id_policy = NameIdPolicy.from_xml(subject)
          end
        }
      end
    end
  end
end
