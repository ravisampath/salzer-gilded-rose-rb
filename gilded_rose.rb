require 'delegate'

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each do |item|
      ItemCollection.collect(item).update
    end
  end

end


#simple delegator class added
class ItemCollection < SimpleDelegator
  def self.collect(item)
    case item.name
    when "Sulfuras, Hand of Ragnaros"
      SulfurasItem.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    when "Conjured Mana Cake"
      ConjuredItem.new(item)
    when "Aged Brie"
      AgedBrie.new(item)
    else
      new(item)
    end
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"
    days
    update_quality
  end

  def days
    self.sell_in -= 1
  end

  def update_quality
    self.quality += change_quality_value
  end

  def change_quality_value
    quality_value = 0

    if sell_in < 0
      quality_value -= 1
    else
      quality_value -= 1
    end

    quality_value
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class SulfurasItem < ItemCollection
  def change_quality_value
    
  end
end

class BackstagePass < ItemCollection
  def change_quality_value
    quality_value = 1
    if sell_in < 11
      quality_value += 1
    end
    if sell_in < 6
      quality_value += 1
    end
    if sell_in < 0
      quality_value -= quality
    end

    quality_value
  end
end

class AgedBrie < ItemCollection
  def change_quality_value
    quality_value = 1
    if sell_in < 0
      quality_value += 1
    end

    quality_value
  end
end


class ConjuredItem < ItemCollection
  def change_quality_value
    quality_value = -2
    if sell_in < 0
      quality_value -= 2
    end
    quality_value
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


# old code

# def initialize(items)
#     @items = items
#   end

#   def update_quality()
#     @items.each do |item|
#       if item.name != 'Aged Brie' and item.name != 'Backstage passes to a TAFKAL80ETC concert'
#         if item.quality > 0
#           if item.name != 'Sulfuras, Hand of Ragnaros'
#             item.quality = item.quality - 1
#           end
#         end
#       else
#         if item.quality < 50
#           item.quality = item.quality + 1
#           if item.name == 'Backstage passes to a TAFKAL80ETC concert'
#             if item.sell_in < 11
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#             if item.sell_in < 6
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#           end
#         end
#       end
#       if item.name != 'Sulfuras, Hand of Ragnaros'
#         item.sell_in = item.sell_in - 1
#       end
#       if item.sell_in < 0
#         if item.name != 'Aged Brie'
#           if item.name != 'Backstage passes to a TAFKAL80ETC concert'
#             if item.quality > 0
#               if item.name != 'Sulfuras, Hand of Ragnaros'
#                 item.quality = item.quality - 1
#               end
#             end
#           else
#             item.quality = item.quality - item.quality
#           end
#         else
#           if item.quality < 50
#             item.quality = item.quality + 1
#           end
#         end
#       end
#     end
#   end
# end
