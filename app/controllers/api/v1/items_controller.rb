require 'update_playerstations'
module Api
  module V1
    class ItemsController < ApiController
      include HTTParty
      include UpdatePlayerstations
      respond_to :json
      # after_action :verify_authorized, except: :index
      # after_action :verify_policy_scoped, only: :index

      def index
        items = []
        # default to Jita
        system = 30_000_142
        if params[:name].present?
          # find item by name
          items = find_item_by_name(params[:name])
        end
        system = params[:system] if params[:system].present?

        solarsystem = Solarsystem.find_by(solarSystemName: system)
        region = solarsystem.region

        items = items.to_ary
        # find item prices
        items.each_with_index do |item, idx|
          items[idx] = item.as_json
          buy = HTTParty.get("https://public-crest.eveonline.com/market/#{region.id}/orders/buy/?type=https://public-crest.eveonline.com/types/#{item[:typeID]}/")
          b_items = JSON.parse buy
          b_items_from_system = []
          b_items['items'].each do |i|
            station = Station.find_by(stationID: i['location']['id'].to_i)
            if station.nil?
              # check to see if player stations need to be updated
              check_playerstations
              station = Playerstation.find_by(stationID: i['location']['id'].to_i)
            end
            if station.solarsystem.solarSystemID == solarsystem.solarSystemID
              b_items_from_system.push(i)
            end
          end
          items[idx]['buy_price'] = get_trimmed_mean(b_items_from_system, 0.2)

          sell = HTTParty.get("https://public-crest.eveonline.com/market/#{region.id}/orders/sell/?type=https://public-crest.eveonline.com/types/#{item[:typeID]}/")
          s_items = JSON.parse sell
          s_items_from_system = []
          s_items['items'].each do |i|
            station = Station.find_by(stationID: i['location']['id'].to_i)
            if station.nil?
              # check to see if player stations need to be updated
              check_playerstations
              station = Playerstation.find_by(stationID: i['location']['id'].to_i)
            end
            if station.solarsystem.solarSystemID == solarsystem.solarSystemID
              s_items_from_system.push(i)
            end
          end
          items[idx]['sell_price'] = get_trimmed_mean(s_items_from_system, 0.2)

          items[idx]['system'] = solarsystem.solarSystemName
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

      private

      def check_playerstations
        return if Playerstation.first.created_at < Date.current - 1.hour
        UpdatePlayerstations.update_playerstations
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
          if price > 1_000_000_000
            price /= 1_000_000_000
            price = price.round(2).to_s + 'B isk'
          elsif price > 1_000_000
            price /= 1_000_000
            price = price.round(2).to_s + 'M isk'
          elsif price > 1000
            price /= 1000
            price = price.round(2).to_s + 'K isk'
          else
            price = price.round(2).to_s + ' isk'
          end
          return price
        end
        'N/A'
      end
    end
  end
end
