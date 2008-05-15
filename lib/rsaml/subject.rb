module RSAML
  # Specifies the principal that is the subject of all of the (zero or more) 
  # statements in an assertion.
  class Subject
    
    # The subject identifier
    attr_accessor :identifier
    
    # Initialize the subject with the given identifier
    def initialize(identifier=nil)
      @identifier = identifier
    end
    
    # Information that allows the subject to be confirmed. If more than one subject confirmation is provided, 
    # then satisfying any one of them is sufficient to confirm the subject for the purpose of applying the 
    # assertion.
    def subject_confirmations
      @subject_confirmations ||= []
    end
  end
end