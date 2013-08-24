class Chef
  class Node
    class Attribute
      class << self
        # Recurse thru the given multi-level hash or chef attribute
        # and create a flattened hash with concatened keys
        def rjoin_keys(v, separator=".", prefix='', h={})
          case v
          when Hash, Chef::Node::Attribute
            prefix += "." unless prefix.empty?
            v.each do |key, value|
              rjoin_keys(value, separator, "#{prefix}#{key}", h)
            end
          when Array
            h[prefix]=v.join(" ")
          else
            h[prefix]=v
          end
          return h
        end
      end
    end
  end
end
