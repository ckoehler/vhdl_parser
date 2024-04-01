class String

  # Addition to String class that determines if a String is 
  # numeric.
  # @return [boolean] Whether the String is numeric.
  def is_numeric?
    true if Float(self) rescue false
  end
end
