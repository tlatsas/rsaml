RSAML
=====

About
-----

RSAML is a SAML implementation in Ruby. RSAML currently implements the elements
defined in the SAML-Core 2.0 specification by defining an object model that
mimics the structure of SAML.

Method names and attributes have been made ruby-friendly and documentation is
provided for almost each class and method. In certain cases the SAML specification
is referenced directly and should be considered the final say whenever a question
arises regarding SAML implementation.

Concrete requests:

* RSAML::Protocol::Query::AuthnQuery (Authentication query)
* RSAML::Protocol::Query::AttributeQuery (Attribute query)
* RSAML::Protocol::Query::AuthzDecisionQuery (Authorization query)

Project status
-----

[![Build Status](https://secure.travis-ci.org/rsaml/rsaml.png?branch=master)](https://travis-ci.org/rsaml/rsaml)
[![Dependency Status](https://gemnasium.com/rsaml/rsaml.png)](http://gemnasium.com/rsaml/rsaml)

RSAML is currently (as of Nov 2012) under major rework.
Most notable missing/half-baked features :

* XML Signing / Signature verification
* SAML 2.0 Bindings implementations
* Half-baked core protocol elements serialization/deserialization

Ruby support
------

Actively supported and maintained versions are:

* Ruby 2.1.0
* Ruby 2.0.0
* Ruby 1.9.3
* JRuby (1.9 mode)

A note on the implementation
-----

RSAML is implemented in a very verbose fashion. While there are probably ways to
reduce the code footprint using meta programming and other Rubyisms, it was
attempted to stick to an implementation style that is easy to follow for
non-rubyists and rubyists alike. Additionally a great effort has be given for a
comprehensive test suite that can be used to verify conformance to the SAML 2.0
specification.

Signing XML responses
-----

There is now a rough and experimental approach for signing Assertions in Responses.
It is very rough, hard-coded and ugly. To get it working you need the following:

* [xmlsec](http://www.aleksey.com/xmlsec/xmlsec-man.html) command line tool installed and working
* A valid private key pkcs12 file and it's exact filename set as the environment variable `SAML_CERTIFICATE`
* A valid trusted (root) certificate PEM file and it's exact filename set as the environment variable `SAML_TRUSTED_PEM`
* If the private key has a password it must be set as the environment variable `SAML_CERTIFICATE_PASSWORD`

If you have this, in order to get the assertions signed in a Response message you
have to do something like the following:

```ruby
response = RSAML::Protocol::Response.new
# ...

# Generate the XML signature template for each assertion that exists in a response.
# In order for this to work the #id *must be already set* on the assertion object.
# This template is later used by the xmlsec1 tool to know what it is that needs to be signed.
response.assertions.each { |assertion| assertion.generate_assertion_signature_template  }

# Select your binding and tell it to sign the response before returning you the encoded data.
# This is how it would be for example on the HTTPPost binding, which by 99% is what you want anyway.
encoded_and_encrypted_saml_response = RSAML::Binding::HTTPPost.message_data(response, :pretty => true, :sign => true)
```
**Next steps regarding signing**

* Use actual ruby bindings around xmlsec and not the command line tool.
* Provide a way to configure the key/cert without using environment variables.
* Improve the API of the whole procedure.
* Proper error raising / handling.

TODO
-----

* Use [Addressable](https://rubygems.org/gems/addressable) instead of CGI for URI encoding/decoding.
* Add .from_xml to all applicable classes
* Proper output of namespaces in to_xml
* Use constants where appropriate instead of free form text, like :
  * RSAML::Protocol::AuthnRequest#protocol_binding
  * RSAML::Protocol::NameIdPolicy#format
  * etc..
* Possibly refactor the models to use a DSL for the mapping instead of handwriting
  each time `.from_xml` and `#to_xml`
* Migrate to Nokogiri?
* Pretty output for xml
* Make consistent the naming of the class fields. For example :
    * AuthenticationContext should be AuthnContext
    * AuthnContext#class_reference vs Subject#subject_confirmations
* Attribute.from_xml can not actually handle attribute values
* AttributeValue really supports only xs:string types.
  This should work at least for all xs simple types
* AttributeValue support for nil/empty strings

Contributing
-----

* Fork the repo.
* Make your feature addition or bug fix.
* Add tests for it.
* Commit, do not mess with gemspec, version, or history.
* Send a pull request. Bonus points for topic branches.

Credits
-----

Core author(s)
-----

* [Anthony Eden](http://www.anthonyeden.com)
* [Nikos Dimitrakopoulos](http://blog.nikosd.com)

Maintainer(s)
-----

* [Nikos Dimitrakopoulos](http://blog.nikosd.com)

[Contributors](https://github.com/rsaml/rsaml/graphs/contributors)

License
-----

RSAML is released under the MIT license:

* http://www.opensource.org/licenses/MIT
