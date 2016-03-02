module Api
  module V1
    class ItemsController < ApiController
      include HTTParty
      respond_to :json

      def index
        items = []
        if params[:name].present?
          # find item by name
          items = find_item_by_name(params[:name])
        end
        render json: items.to_json
      end

      def show
        item = if params[:id].to_i > 0
                 # if actually an item id, search by id
                 Item.find_by(typeID: params[:id])
               else
                 # else search by name
                 Item.find_by(typeName: params[:id])
               end
        render json: item.to_json
      end

      def price
        uri_base = 'https://public-crest.eveonline.com/market'
        type_base = 'https://public-crest.eveonline.com/types'
        find_solarsystem
        region = @solarsystem.region
        items = find_item_by_name(params[:name])
        items = items.to_ary
        items.each_with_index do |item, idx|
          items[idx] = item.as_json
          if params.key?(:buy)
            buy = HTTParty.get("#{uri_base}/#{region.id}/orders/buy/?type=#{type_base}/#{item[:typeID]}/")
            system_items = get_items_from_system(buy)
            items[idx]['buy_price'] = get_trimmed_mean(system_items, 0.2)
            items[idx]['system'] = @solarsystem.solarSystemName
          end
          next unless params.key?(:sell)
          sell = HTTParty.get("#{uri_base}/#{region.id}/orders/sell/?type=#{type_base}/#{item[:typeID]}/")
          system_items = get_items_from_system(sell)
          items[idx]['sell_price'] = get_trimmed_mean(system_items, 0.2)
          items[idx]['system'] = @solarsystem.solarSystemName
        end
        render json: items.to_json
      end

      def history
        items = find_item_by_name(params[:name])
        return render json: { error: 'Invalid item names', status: :bad_request }, status: :bad_request if items.count == 0
        result = []
        items.each do |item|
          to_push = {}
          to_push['typeID'] = item.typeID
          to_push['history'] = item.itemHistories.select('id,orderCount,lowPrice,highPrice,avgPrice,volume,date').as_json
          result << to_push
        end
        render json: result.to_json
      end

      private

      def get_items_from_system(item_list)
        items = JSON.parse item_list
        items_from_system = []
        items['items'].each do |i|
          station = Station.find_by(stationID: i['location']['id'].to_i, solarSystemID: @solarsystem.solarSystemID)
          if station.nil?
            station = PlayerStation.find_by(stationID: i['location']['id'].to_i, solarSystemID: @solarsystem.solarSystemID)
          end
          items_from_system.push(i) unless station.nil?
        end
        items_from_system
      end

      def find_solarsystem
        @solarsystem = if params.key?(:system)
                         SolarSystem.find_by(solarSystemName: params[:system])
                       else
                         # Jita
                         SolarSystem.find(30_000_142)
                       end
      end

      def find_item_by_name(names)
        return Item.where(typeName: names.split(',')) if names.include?(',')
        Item.where(typeName: names)
      end

      def get_trimmed_mean(items, trim_percentage)
        unless items.empty?
          item_prices = items.map { |item| item['price'] }.sort
          to_trim = (item_prices.size * trim_percentage).round
          trimmed_items = item_prices.slice(to_trim..(item_prices.size - to_trim))
          price = trimmed_items.sum / trimmed_items.size.to_f
          return price.round(2)
        end
        0
      end
    end
  end
end
