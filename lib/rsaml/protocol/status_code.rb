module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A code or a set of nested codes representing the status of the corresponding request.
    class StatusCode
      # The available values for status codes.
      # More information can be found in Section 3.2.2.2 of the SAML 2.0 Core specification.
      module Values
        # The request succeeded. Additional information MAY be returned in the <StatusMessage>
        # and/or <StatusDetail> elements.
        SUCCESS = 'urn:oasis:names:tc:SAML:2.0:status:Success'.freeze

        # The request could not be performed due to an error on the part of the requester.
        REQUESTER = 'urn:oasis:names:tc:SAML:2.0:status:Requester'.freeze

        # The request could not be performed due to an error on the part of the SAML responder
        # or SAML authority.
        RESPONDER = 'urn:oasis:names:tc:SAML:2.0:status:Responder'.freeze

        # The SAML responder could not process the request because the version of the request message
        # was incorrect.
        VERSION_MISMATCH = 'urn:oasis:names:tc:SAML:2.0:status:VersionMismatch'.freeze

        # The responding provider was unable to successfully authenticate the principal.
        AUTHN_FAILED = 'urn:oasis:names:tc:SAML:2.0:status:AuthnFailed'.freeze

        # Unexpected or invalid content was encountered within a <saml:Attribute> or
        # <saml :AttributeValue> element.
        INVALID_ATTR_NAME_OR_VALUE = 'urn:oasis:names:tc:SAML:2.0:status:InvalidAttrNameOrValue'.freeze

        # The responding provider cannot or will not support the requested name identifier policy.
        INVALID_NAME_ID_POLICY = 'urn:oasis:names:tc:SAML:2.0:status:InvalidNameIDPolicy'.freeze

        # The specified authentication context requirements cannot be met by the responder.
        NO_AUTHN_CONTEXT = 'urn:oasis:names:tc:SAML:2.0:status:NoAuthnContext'.freeze

        # Used by an intermediary to indicate that none of the supported identity provider
        # <Loc> elements in an <IDPList> can be resolved or that none of the supported identity
        # providers are available.
        NO_AVAILABLE_IDP = 'urn:oasis:names:tc:SAML:2.0:status:NoAvailableIDP'.freeze

        # Indicates the responding provider cannot authenticate the principal passively, as has been requested.
        NO_PASSIVE = 'urn:oasis:names:tc:SAML:2.0:status:NoPassive'.freeze

        # Used by an intermediary to indicate that none of the identity providers in an <IDPList> are
        # supported by the intermediary.
        NO_SUPPORTED_IDP = 'urn:oasis:names:tc:SAML:2.0:status:NoSupportedIDP'.freeze

        # Used by a session authority to indicate to a session participant that it was not able to
        # propagate logout to all other session participants.
        PARTIAL_LOGOUT = 'urn:oasis:names:tc:SAML:2.0:status:PartialLogout'.freeze

        # Indicates that a responding provider cannot authenticate the principal directly and
        # is not permitted to proxy the request further.
        PROXY_COUNT_EXCEEDED = 'urn:oasis:names:tc:SAML:2.0:status:ProxyCountExceeded'.freeze

        # The SAML responder or SAML authority is able to process the request but has chosen not to respond.
        # This status code MAY be used when there is concern about the security context of the request message
        # or the sequence of request messages received from a particular requester.
        REQUEST_DENIED = 'urn:oasis:names:tc:SAML:2.0:status:RequestDenied'.freeze

        # The SAML responder or SAML authority does not support the request.
        REQUEST_UNSUPPORTED = 'urn:oasis:names:tc:SAML:2.0:status:RequestUnsupported'.freeze

        # The SAML responder cannot process any requests with the protocol version specified in the request.
        REQUEST_VERSION_DEPRECATED = 'urn:oasis:names:tc:SAML:2.0:status:RequestVersionDeprecated'.freeze

        # The SAML responder cannot process the request because the protocol version specified in the
        # request message is a major upgrade from the highest protocol version supported by the responder.
        REQUEST_VERSION_TOO_HIGH = 'urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooHigh'.freeze

        # The SAML responder cannot process the request because the protocol version specified in the request
        # message is too low.
        REQUEST_VERSION_TOO_LOW = 'urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooLow'.freeze

        # The resource value provided in the request message is invalid or unrecognized.
        RESOURCE_NOT_RECOGNIZED = 'urn:oasis:names:tc:SAML:2.0:status:ResourceNotRecognized'.freeze

        # The response message would contain more elements than the SAML responder is able to return.
        TOO_MANY_RESPONSE = 'urn:oasis:names:tc:SAML:2.0:status:TooManyResponse'.freeze

        # An entity that has no knowledge of a particular attribute profile has been presented
        # with an attribute drawn from that profile.
        UNKNOWN_ATTR_PROFILE = 'urn:oasis:names:tc:SAML:2.0:status:UnknownAttrProfile'.freeze

        # The responding provider does not recognize the principal specified or implied by the request.
        UNKNOWN_PRINCIPAL = 'urn:oasis:names:tc:SAML:2.0:status:UnknownPrincipal'.freeze

        # The SAML responder cannot properly fulfill the request using the protocol binding
        # specified in the request.
        UNSUPPORTED_BINDING = 'urn:oasis:names:tc:SAML:2.0:status:UnsupportedBinding'.freeze
      end

      # Hash of symbol/StatusCode pairs representing top-level status codes.
      TOP_LEVEL_MAPPINGS = {
          :success => Values::SUCCESS,
          :requester => Values::REQUESTER,
          :responder => Values::RESPONDER,
          :version_mismatch => Values::VERSION_MISMATCH
      }

      # Hash of symbol/StatusCode pairs representing second-level status codes.
      SECOND_LEVEL_MAPPINGS = {
          :authn_failed => [Values::RESPONDER, Values::AUTHN_FAILED],
          :invalid_attr_name_or_value => [Values::REQUESTER, Values::INVALID_ATTR_NAME_OR_VALUE],
          :invalid_name_id_policy => [Values::REQUESTER, Values::INVALID_NAME_ID_POLICY],
          :no_authn_context => [Values::RESPONDER, Values::NO_AUTHN_CONTEXT],
          :no_available_idp => [Values::RESPONDER, Values::NO_AVAILABLE_IDP],
          :no_passive => [Values::RESPONDER, Values::NO_PASSIVE],
          :no_supported_idp => [Values::RESPONDER, Values::NO_SUPPORTED_IDP],
          :partial_logout => [Values::RESPONDER, Values::PARTIAL_LOGOUT],
          :proxy_count_exceeded => [Values::RESPONDER, Values::PROXY_COUNT_EXCEEDED],
          :request_denied => [Values::RESPONDER, Values::REQUEST_DENIED],
          :request_unsupported => [Values::RESPONDER, Values::REQUEST_UNSUPPORTED],
          :request_version_deprecated => [Values::VERSION_MISMATCH, Values::REQUEST_VERSION_DEPRECATED],
          :request_version_too_high => [Values::RESPONDER, Values::REQUEST_VERSION_TOO_HIGH],
          :request_version_too_low => [Values::RESPONDER, Values::REQUEST_VERSION_TOO_LOW],
          :resource_not_recognized => [Values::REQUESTER, Values::RESOURCE_NOT_RECOGNIZED],
          :too_many_responses => [Values::RESPONDER, Values::TOO_MANY_RESPONSE],
          :unknown_attr_profile => [Values::RESPONDER, Values::UNKNOWN_ATTR_PROFILE],
          :unknown_principal => [Values::RESPONDER, Values::UNKNOWN_PRINCIPAL],
          :unsupported_binding => [Values::RESPONDER, Values::UNSUPPORTED_BINDING],
      }

      # The status code value. Value is a URI reference.
      # The value of this if the current status code is the topmost one,
      # must be from the top-level status codes.
      attr_accessor :value
      
      # An optional subordinate status code that provides more specific information on an error condition.
      # Value is a StatusCode.
      attr_accessor :status_code

      # Initialize the status code with the given value
      def initialize(value)
        if value.kind_of? Symbol
          if SECOND_LEVEL_MAPPINGS.include? value
            @value = SECOND_LEVEL_MAPPINGS[value][0]
            @status_code = self.class.new(SECOND_LEVEL_MAPPINGS[value][1])
          elsif TOP_LEVEL_MAPPINGS.include? value
            @value = TOP_LEVEL_MAPPINGS[value]
          else
            raise ArgumentError.new("Symbol #{value} does not have a mapping!")
          end
        else
          @value = value
        end
      end

      def validate
        raise ValidationError, "Value is required" if value.nil?
      end
      
      # Construct an XML fragment representing the request
      # XML Schema :
      #
      #   <element name="StatusCode" type="samlp:StatusCodeType"/>
      #   <complexType name="StatusCodeType">
      #     <sequence>
      #       <element ref="samlp:StatusCode" minOccurs="0"/>
      #     </sequence>
      #     <attribute name="Value" type="anyURI" use="required"/>
      #   </complexType>
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'Value' => value}
        xml.tag!('samlp:StatusCode', attributes) {
          xml << status_code.to_xml unless status_code.nil?
        }
      end
      
      # Return the value of the status code as a string.
      def to_s
        value
      end
    end
  end
end
