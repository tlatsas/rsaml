require File.dirname(__FILE__) + '/../test_helper'

class AuthnResponseProductionTest < Test::Unit::TestCase
  include RSAML::Protocol
  include RSAML::Identifier

  context "success response" do
    context "empty" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:success)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Success'/>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end

    context "simple authn with issuer, subject and attributes" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:success)))
        response.id = "_54A11A4E88629F3A5E2DC62461BD428E"
        response.issue_instant = Time.parse('2008-05-27T11:11:33Z')
        response.issuer = Issuer.new('http://idp.example.com')

        assertion = Assertion.new(response.issuer)
        assertion.id = '_563301B7AD08D81EEA502077C1DB4160'
        assertion.issue_instant = Time.parse('2008-05-27T11:11:33Z')

        subject_name_identifier = Name.new('_3AEC2A5675C630B61891233565F7FA2B')
        subject_name_identifier.format = Name.formats[:transient]
        subject_confirmation = SubjectConfirmation.new(SubjectConfirmation.methods[:bearer])
        subject_confirmation_data = SubjectConfirmationData.new
        subject_confirmation_data.not_on_or_after = Time.parse('2008-05-27T11:21:33Z')
        subject_confirmation.subject_confirmation_data = subject_confirmation_data
        subject = Subject.new(subject_name_identifier)
        subject.subject_confirmations << subject_confirmation
        assertion.subject = subject

        authn_context = AuthenticationContext.new
        authn_context.class_reference = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'
        authn_statement = AuthenticationStatement.new(authn_context)
        authn_statement.authn_instant = Time.parse('2008-05-27T11:11:33Z')
        authn_statement.session_index = '125279ba015dc4bd'
        authn_statement.session_not_on_or_after = Time.parse('2008-05-27T11:21:33Z')

        attribute_statement = AttributeStatement.new
        mail_attribute = Attribute.new('mail', AttributeValue.new('someone@example.com'))
        mail_attribute.name_format = 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic'
        attribute_statement.attributes << mail_attribute

        assertion.statements << authn_statement
        assertion.statements << attribute_statement

        response.assertions << assertion

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='_54A11A4E88629F3A5E2DC62461BD428E' Version='2.0' IssueInstant='2008-05-27T11:11:33Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <saml:Issuer Format='urn:oasis:names:tc:SAML:2.0:nameid-format:entity'>
        http://idp.example.com
    </saml:Issuer>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Success'/>
    </samlp:Status>
    <saml:Assertion ID='_563301B7AD08D81EEA502077C1DB4160' Version='2.0' IssueInstant='2008-05-27T11:11:33Z'>
        <saml:Issuer Format='urn:oasis:names:tc:SAML:2.0:nameid-format:entity'>
            http://idp.example.com
        </saml:Issuer>
        <saml:Subject>
            <saml:NameID Format='urn:oasis:names:tc:SAML:2.0:nameid-format:transient'>
                _3AEC2A5675C630B61891233565F7FA2B
            </saml:NameID>
            <saml:SubjectConfirmation Method='urn:oasis:names:tc:SAML:2.0:cm:bearer'>
                <saml:SubjectConfirmationData NotOnOrAfter='2008-05-27T11:21:33Z'/>
            </saml:SubjectConfirmation>
        </saml:Subject>
        <saml:AuthnStatement AuthnInstant='2008-05-27T11:11:33Z' SessionIndex='125279ba015dc4bd' SessionNotOnOrAfter='2008-05-27T11:21:33Z'>
            <saml:AuthnContext>
                <saml:AuthnContextClassRef>
                    urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport
                </saml:AuthnContextClassRef>
            </saml:AuthnContext>
        </saml:AuthnStatement>
        <saml:AttributeStatement>
            <saml:Attribute Name='mail' NameFormat='urn:oasis:names:tc:SAML:2.0:attrname-format:basic'>
                <saml:AttributeValue xmlns:xs='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:type='xs:string'>
                    someone@example.com
                </saml:AttributeValue>
            </saml:Attribute>
        </saml:AttributeStatement>
    </saml:Assertion>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end
  end

  context "requester error response" do
    context "simple" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:requester)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Requester'/>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end

    context "invalid attribute name or value" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:invalid_attr_name_or_value)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Requester'>
            <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:InvalidAttrNameOrValue'/>
        </samlp:StatusCode>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end

    context "invalid name id policy" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:invalid_name_id_policy)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Requester'>
            <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:InvalidNameIDPolicy'/>
        </samlp:StatusCode>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end
  end

  context "responder error response" do
    context "simple" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:responder)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Responder'/>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end

    context "authentication failed" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:authn_failed)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Responder'>
            <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:AuthnFailed'/>
        </samlp:StatusCode>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end

    context "no passive" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:no_passive)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:Responder'>
            <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:NoPassive'/>
        </samlp:StatusCode>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end
  end

  context "version mismatch error response" do
    context "simple" do
      should "match xml" do
        response = Response.new(Status.new(StatusCode.new(:version_mismatch)))
        response.id = "59314df0-774a-012f-63b3-00242131fa16"
        response.issue_instant = Time.parse('2012-05-03T12:35:11Z')

        expected_xml = <<XML
<?xml version='1.0' encoding='UTF-8'?>
<samlp:Response ID='59314df0-774a-012f-63b3-00242131fa16' Version='2.0' IssueInstant='2012-05-03T12:35:11Z' xmlns:samlp='urn:oasis:names:tc:SAML:2.0:protocol' xmlns:saml='urn:oasis:names:tc:SAML:2.0:assertion'>
    <samlp:Status>
        <samlp:StatusCode Value='urn:oasis:names:tc:SAML:2.0:status:VersionMismatch'/>
    </samlp:Status>
</samlp:Response>
XML

        assert_generated_xml expected_xml, response
      end
    end
  end

  #########
  protected
  #########

  def assert_generated_xml(expected_xml, response, output = false)
    xml = Builder::XmlMarkup.new
    xml.instruct!

    formatter = REXML::Formatters::Pretty.new(4)
    actual_xml = ""
    formatter.write(REXML::Document.new((response.to_xml(xml))), actual_xml)

    if output
      puts "Expected xml:\n\n#{expected_xml}\n----------------"
      puts "Actual xml:\n\n#{actual_xml}"
      puts "=================================================="
    end

    assert_equal expected_xml.strip, actual_xml.strip
  end
end
