module XmlSig #:nodoc:
  class KeyInfo
    attr_accessor :id
    attr_accessor :key_name
    attr_accessor :key_value
    attr_accessor :retrieval_method
    attr_accessor :key_data
    attr_accessor :x509_data

    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('ds:KeyInfo') {
        xml << x509_data.to_xml if x509_data
        xml.tag!('ds:KeyName', key_name) if key_name
        xml.tag!('ds:KeyValue') {
          xml << key_value.to_xml if key_value
        }
      }
    end
  end
  
  class RetrievalMethod
    attr_accessor :uri
    attr_accessor :type
    
    def transforms
      @transforms ||= []
    end
    
    def validate
      raise ValidationError, "URI is required" if uri.nil?
    end
    
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'URI' => uri}
      attributes['Type'] = type unless type.nil?
      xml.tag!('ds:RetrievalMethod', attributes) {
        transforms.each { |transform| xml << transform.to_xml }
      }
    end
  end

  # REQUIRED
  class DSAKeyValue
  end
  # OPTIONAL
  class RSAKeyValue
  end

  class X509Data
    attr_accessor :x509_certificate

    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('ds:X509Data') {
        xml.tag!('ds:X509Certificate', x509_certificate)
      }
    end
  end

  class PGPData
  end

  class SPKIData
  end

  class MgmtData
  end
end
