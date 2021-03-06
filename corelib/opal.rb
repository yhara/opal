require 'runtime'
require 'module'
require 'class'
require 'basic_object'
require 'kernel'
require 'nil_class'
require 'boolean'
require 'error'
require 'regexp'
require 'comparable'
require 'enumerable'
require 'enumerator'
require 'array'
require 'hash'
require 'string'
require 'match_data'
require 'encoding'
require 'numeric'
require 'proc'
require 'method'
require 'range'
require 'time'
require 'struct'
require 'native'
require 'io'
require 'main'

# regexp matches
$& = $~ = $` = $' = nil

# stub library path
$:            = []

# split lines
$/            = "\n"
$,            = " "

ARGV          = []
ARGF          = Object.new
ENV           = {}

RUBY_PLATFORM = 'opal'
RUBY_ENGINE   = 'opal'
RUBY_VERSION  = '1.9.3'
RUBY_ENGINE_VERSION = '0.4.4'
RUBY_RELEASE_DATE = '2013-08-13'

module Opal
  def self.coerce_to(object, type, method)
    return object if type === object

    unless object.respond_to? method
      raise TypeError, "no implicit conversion of #{object.class} into #{type}"
    end

    object.__send__ method
  end

  def self.truthy?(value)
    if value
      true
    else
      false
    end
  end

  def self.falsy?(value)
    if value
      false
    else
      true
    end
  end

  def self.destructure(args)
    %x{
      if (args.length == 1) {
        return args[0];
      }
      else if (args._isArray) {
        return args;
      }
      else {
        return $slice.call(args);
      }
    }
  end
end
