class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"
        item.quality = [item.quality + 1, 50].min if item.quality < 50
      when "Backstage passes to a TAFKAL80ETC concert"
        item.quality = [item.quality + quality_increment(item.sell_in), 50].min
      when "Sulfuras, Hand of Ragnaros"
        # Sulfuras does not change
      else
        item.quality = [item.quality - quality_decrement(item.sell_in), 0].max
      end
  
      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
  
      if item.sell_in < 0
        case item.name
        when "Aged Brie"
          item.quality = [item.quality + 1, 50].min if item.quality < 50
        when "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        else
          item.quality = [item.quality - quality_decrement(item.sell_in), 0].max
        end
      end
    end
  end
  
  # Helper methods
  def quality_increment(sell_in)
    return 3 if sell_in <= 5
    return 2 if sell_in <= 10
    1
  end
  
  def quality_decrement(sell_in)
    return 2 if sell_in < 0
    1
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
