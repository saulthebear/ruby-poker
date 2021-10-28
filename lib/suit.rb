require 'colorize'

class Suit
  NAMES = %w[spade heart diamond club].freeze
  SYMBOLS = %w[♠ ♥ ♦ ♣].freeze

  attr_reader :name, :color, :symbol

  def initialize(name)
    raise ArgumentError, 'Incorrect suit name.' unless NAMES.include?(name)

    @name = name
    @color = :red if @name == 'heart' || @name == 'diamond'
    @color = :light_black if @name == 'spade' || @name == 'club'

    @symbol = SYMBOLS[NAMES.index(@name)]
  end

  def to_s
    @symbol.colorize(color: @color)
  end

  def inspect
    "<#{self}>"
  end
end
