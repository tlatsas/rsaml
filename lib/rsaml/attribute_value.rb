module RSAML #:nodoc:
  # The actual value of an `Attribute`.
  # Currently supports only xs:string value types
  class AttributeValue
    attr_accessor :value

    def initialize(value = nil)
      @value = value
    end

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {
          'xmlns:xs' => 'http://www.w3.org/2001/XMLSchema',
          'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
          'xsi:type' => 'xs:string'
      }
      xml.tag!('saml:AttributeValue', attributes, value.to_s)
    end
  end
end
