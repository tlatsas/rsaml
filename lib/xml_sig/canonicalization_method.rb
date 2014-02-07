module XmlSig #:nodoc:
  class CanonicalizationMethod
    attr_accessor :algorithm

    def validate
      raise ValidationError, "Algorithm is required" if algorithm.nil?
    end

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'Algorithm' => algorithm}
      xml.tag!('ds:CanonicalizationMethod', attributes)
    end
  end
  
  class XMLC14NBase
    # Fix for Iconv and Ruby 2. Taken from: https://gist.github.com/7hunderbird/5159050
    if ::String.method_defined?(:encode)
      # Encodes string using Ruby's _String.encode_
      def self.iconv(to, from, string)
        string.encode(to, from)
      end
    else
      require 'iconv'
      # Encodes string using _iconv_ library
      def self.iconv(to, from, string)
        Iconv.conv(to, from, string).join
      end
    end

    # Convert the content from the given charset to UTF-8.
    def convert_to_utf8(content, from)
      self.class.iconv('UTF-8', from, content)
    end
    def convert_linebreaks(content)
      content.gsub(/\r\n/, "\n").gsub(/\r/, "\n")
    end
    def normalize_attribute_values(content)
      
    end
  end
  
  # Canonicalization algorithm for XML removing comments
  class XMLC14NWithComments < XMLC14NBase
    def process(content, charset='UTF-8')
      content = convert_to_utf8(content) unless charset == 'UTF-8'
      content
    end
  end
  class XMLC14NWithoutComments < XMLC14NBase
    def process(content, charset='UTF-8')
      content = convert_to_utf8(content) unless charset == 'UTF-8'
      doc = REXML::Document.new(content)
    end
  end
end
