# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

module XmlSig
  class SignatureTest < MiniTest::Test
    SAMPLE_XML_TEMPLATE = <<XML
<ds:Signature xmlns:ds='http://www.w3.org/2000/09/xmldsig#'>
    <ds:SignedInfo>
        <ds:CanonicalizationMethod Algorithm='http://www.w3.org/2001/10/xml-exc-c14n#'/>
        <ds:SignatureMethod Algorithm='http://www.w3.org/2000/09/xmldsig#rsa-sha1'/>
        <ds:Reference URI='#_pfxb27555d8-8c06-a339-c7ae-f544b2fd1507'>
            <ds:Transforms>
                <ds:Transform Algorithm='http://www.w3.org/2000/09/xmldsig#enveloped-signature'/>
                <ds:Transform Algorithm='http://www.w3.org/2001/10/xml-exc-c14n#'/>
            </ds:Transforms>
            <ds:DigestMethod Algorithm='http://www.w3.org/2000/09/xmldsig#sha1'/>
            <ds:DigestValue/>
        </ds:Reference>
    </ds:SignedInfo>
    <ds:SignatureValue/>
    <ds:KeyInfo>
        <ds:X509Data>
            <ds:X509Certificate/>
        </ds:X509Data>
        <ds:KeyValue/>
    </ds:KeyInfo>
</ds:Signature>
XML

    context "xml template" do
      should "be able to be generated for input to xmlsec" do
        signature = Signature.new

        signed_info = SignedInfo.new
        signed_info.canonicalization_method = CanonicalizationMethod.new.tap { |cm| cm.algorithm = "http://www.w3.org/2001/10/xml-exc-c14n#" }
        signed_info.signature_method = SignatureMethod.new.tap { |cm| cm.algorithm = "http://www.w3.org/2000/09/xmldsig#rsa-sha1" }

        reference = Reference.new
        reference.uri = '#_pfxb27555d8-8c06-a339-c7ae-f544b2fd1507'
        enveloped_signature_tranform = Transform.new.tap { |t| t.algorithm = EnvelopedSignatureTransform::IDENTIFIER }
        c14n_tranform = Transform.new.tap { |t| t.algorithm = "http://www.w3.org/2001/10/xml-exc-c14n#" }
        reference.transforms << enveloped_signature_tranform
        reference.transforms << c14n_tranform
        reference.digest_method = DigestMethod.new.tap { |d| d.algorithm = DigestMethod.identifiers['SHA-1'] }
        reference.digest_value = ''
        signed_info.references << reference

        signature.signed_info = signed_info

        key_info = KeyInfo.new
        x509_data = X509Data.new
        x509_data.x509_certificate = ''
        key_info.x509_data = x509_data
        signature.key_info = key_info

        xml = Builder::XmlMarkup.new
        formatter = REXML::Formatters::Pretty.new(4)
        pretty_xml = ""
        formatter.write(REXML::Document.new(signature.to_xml(xml)), pretty_xml)

        assert_equal SAMPLE_XML_TEMPLATE.strip, pretty_xml.strip
      end
    end
  end
end
