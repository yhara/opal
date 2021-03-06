class Enumerator
  include Enumerable

  class Yielder
    def initialize(enumerator, block, to)
      @enumerator = enumerator
      @block      = block
      @to         = to
    end

    def yield(*values)
      @to.call(*values)
    end

    alias << yield

    def call
      @block.call(self)
    end
  end

  def initialize(obj = nil, method = :each, *args, &block)
    if block
      @block = block
    else
      @object = obj
      @method = method
      @args   = args
    end
  end

  def each(&block)
    return enum_for :each unless block_given?

    if @block
      Yielder.new(self, @block, block).call
    else
      @object.__send__(@method, *@args, &block)
    end
  end

  def next
    @cache ||= to_a

    raise StopIteration, 'end of enumeration' if @cache.empty?

    @cache.shift
  end

  def rewind
    @cache = nil

    self
  end
end
