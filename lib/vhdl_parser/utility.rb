module VHDL_Parser
  class Utility
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
        p foreval
        ret = eval(foreval)
      rescue NameError => e
      end
      # if nothing was replaced, we get nil, so instead of returning nil,
      # just return the original target, meaning this was just a noop.
      ret.nil? ? target.to_s : ret
    end
  end
end
