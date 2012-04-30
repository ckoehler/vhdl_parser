module VHDL_Parser
  class Extractor

    def self.extract_name(string)
      names = string.split(":").map! { |e| e.strip}
      names[0].split(/\s*,\s*/)
    end

    def self.extract_direction(string)
      res = string.match(/:\s*(in|out|inout)/)
      if res[1]
        return res[1]
      end
      ""
    end

    def self.extract_type(string)
      res =  string.match(/:\s*(?:in|out|inout)?\s+(\w+)/i)
      if res[1]
        return res[1]
      end
      ""
    end

    def self.extract_size(string)
      res = string.match(/\((.*?)\s+(downto|to)\s+(.+?)\)/i)
      if res 
        return res
      end
      ""
    end

    def self.extract_range(string)
      res = string.match(/range\s+(.*?)\s+(downto|to)\s+([-a-z0-9_]*)/i)
      if res 
        return res
      end
      ""
    end

    def self.extract_comment(string)
      res = string.match(/--(.*)$/)
      if res && res[0]
        return res[0]
      end
      ""
    end

    def self.extract_package_constants(string)
      body = string.match(/package\s+(.*)\s+is\s+(.*)\s*end\s*\1;/im)
      name = body[1]
      constants = body[2]
      constants.scan /constant\s+(\w+)\s*:\s*(\w+)\s*:=\s*(.*);/i
    end

    def self.extract_value(string)
      res = string.match /:=\s*([xo"0-9a-z_]*)/i
      if res && res[1]
        return res[1]
      end
      ""
    end
  end
end
