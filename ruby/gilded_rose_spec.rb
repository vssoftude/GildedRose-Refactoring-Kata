require File.join(File.dirname(__FILE__), 'gilded_rose')

require 'rspec'

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end
end

RSpec.describe 'GildedRose' do
  describe '#update_quality' do
    context 'with normal items' do
      it 'decreases quality and sell_in values' do
        items = [Item.new('Normal Item', 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(9)
        expect(items[0].sell_in).to eq(4)
      end

      it 'does not decrease quality below 0' do
        items = [Item.new('Normal Item', 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
        expect(items[0].sell_in).to eq(-1)
      end
    end

    context 'with Aged Brie' do
      it 'increases quality and decreases sell_in' do
        items = [Item.new('Aged Brie', 3, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(11)
        expect(items[0].sell_in).to eq(2)
      end

      it 'does not increase quality above 50' do
        items = [Item.new('Aged Brie', 3, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(50)
        expect(items[0].sell_in).to eq(2)
      end
    end

    context 'with Sulfuras' do
      it 'does not change quality or sell_in' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(80)
        expect(items[0].sell_in).to eq(0)
      end
    end

    context 'with Backstage passes' do
      it 'increases quality, especially when close to the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(21)
        expect(items[0].sell_in).to eq(10)
      end

      it 'increases quality by 2 when 10 days or less to the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(22)
        expect(items[0].sell_in).to eq(9)
      end

      it 'increases quality by 3 when 5 days or less to the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(23)
        expect(items[0].sell_in).to eq(4)
      end

      it 'sets quality to 0 after the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(0)
        expect(items[0].sell_in).to eq(-1)
      end
    end
  end
end
