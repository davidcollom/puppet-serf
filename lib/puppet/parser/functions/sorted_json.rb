#
# sorted_json.rb
# Puppet module for outputting json in a sorted consistent way. I use it for creating config files with puppet

require 'json'

def sorted_json(data)
    if (data.is_a?(Fixnum) ||
        data.is_a?(Float) ||
        data.is_a?(NilClass) ||
        data.is_a?(Symbol) ||
        data.is_a?(String) ||
        !!data == data)
      data.to_json
    elsif data.is_a? Array
      '[' + data.map { |x| sorted_json(x) }.join(',') + ']'
    elsif data.is_a? Hash
      data = data.inject({}) { |m, (k, v)| m[k.to_s] = v; m }
      '{' + data.keys.sort.map { |k| k.to_json + ':' + sorted_json(data[k]) }.join(',') + '}'
    else
      raise Exception('Unable to handle object type ' + data.class)
    end
end

module Puppet::Parser::Functions
  newfunction(:sorted_json, :type => :rvalue, :doc => <<-EOS
This function takes data, outputs making sure the hash keys are sorted

*Examples:*

    sorted_json({'key'=>'value'})

Would return: {'key':'value'}
    EOS
  ) do |arguments|
    raise(Puppet::ParseError, "sorted_json(): Wrong number of arguments " +
        "given (#{arguments.size} for 1)") if arguments.size != 1
    sorted_json(arguments[0])
  end
end