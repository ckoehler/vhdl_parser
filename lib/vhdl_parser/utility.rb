module VHDL_Parser
  # Utility class with helpers
  class Utility

    # Substitutes a constant with an actual value, and does so smartly.
    # This method uses the `eval` method to evaluate the final Math expression
    # into a single value. It does some basic input checking and replaces everything
    # that's not a number or mathematical operator with "x". That should prevent
    # some abuse.
    #
    # @param [target] String The size string, e.g. "MY_VALUE-1"
    # @param [key] String The key string, e.g. "MY_VALUE". This gets compared to the target.
    # @param [value] String The value string, e.g. "8". That's what MY_VALUE gets replaced with.
    def self.sub_constants(target, key, value)
      # first get all the words of the size. That could be
      # a number or a constant.
      words = target.to_s.scan /\w+/
      ret = ""  
      words.each do |w|
        # if a word matches the key and it's not numeric, it must 
        # be a constant that we want to replace
        if w.eql?(key) and not w.is_numeric?
          # so replace it here with the given value
          ret = target.gsub(w,value).to_s
        end
      end

      # now eval the result. If a constant has been replaced with a 
      # value, it could be something like "8-1", so eval that into 7.
      # In case it's still a constant, catch the NameError but ignore it;
      # chances are the constant will be replaced later.
      begin
        # since we're eval'ing here, do some basic cleanup to prevent badness.
        # Specifically, replace anything that's not a number or basic math
        # function with 'xx', since those should trigger the exception anyway.
        foreval = ret.gsub(/[^-+*\/\d\(\)\s]/,'xx')
        ret = eval(foreval)
      rescue NameError => e
      end
      # if nothing was replaced, we get nil, so instead of returning nil,
      # just return the original target, meaning this was just a noop.
      ret.nil? ? target.to_s : ret
    end
  end
end
