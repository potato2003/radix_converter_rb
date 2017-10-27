require "radix_converter/version"

class RadixConverter

  attr_reader :from_radix, :from_reperesentation, :to_radix, :to_representation


  # required argusments:
  # - from .. to convert source radix
  # - to   .. to convert destination radix
  #
  # optional arguments:
  # - representations [string] this list must be orderd
  #
  # currently unsupported: negative number
  def initialize(from: 10, to:, **opts)

    @from_radix, @from_representation = init_radix_param(:from, from)
    @to_radix,   @to_representation   = init_radix_param(:to, to)

  end

  # convert to destination radix from source radix 
  #
  # 'ABZ' => 110
  def convert(n)
    # convert from source radix to decimal
    d = decimal(n)
    return d if to_radix == 10

    # convert from decimal to dest radix
      i = 0
      result = ""
    loop do
      i += 1
      r = d % to_radix
      d = d / to_radix

      p "r="+r, "to_repr="+to_representation[r]
      result << to_representation[r]

      break if (0 == d) and i > 10
    end

    result.reverse!
  end

private

  def init_radix_param(name, radix)
    case radix
    when Integer
      unless ruby_support_radix?(radix)
        raise ArgumentError, "#{name} arguments must be less than 36 when using Integer"
      end

      [radix, nil]

    when Array
      [radix.length, radix]

    when Range
      init_radix_param(name, radix.to_a)

    else
      raise ArgumentError, "#{name} arguments must be Integer, Array or Range"
    end
  end

  def decimal(n, src_radix = @from_radix, src_representation = @from_representation)
    # if given Integer, use it treat as decimal
    return n if n.is_a? Integer

    raise ArgumentError, "must be String or Integer" unless n.is_a? String

    if src_representation.nil? and ruby_support_radix? src_radix
      return n.to_i(src_radix)
    end

    # TODO: memorize
    repr = Hash[ src_representation.zip( 0...src_radix ) ]

    n.reverse.each_char.with_index.inject(0) do |current, (char, index)|
      current + repr[char] * (src_radix ** index)
    end
  end

  def ruby_support_radix? n
    n <= 36
  end
end
