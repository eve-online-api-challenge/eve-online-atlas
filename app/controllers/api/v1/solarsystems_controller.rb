module Api
  module V1
    class SolarsystemsController < ApiController
      respond_to :json
      # after_action :verify_authorized, except: :index
      # after_action :verify_policy_scoped, only: :index

      def index
        render json: Solarsystem.all.to_json
      end

      def show
			# find solar system by solarSystemID as int
			system = Solarsystem.where(solarSystemID: params[:id].to_i)
			# create output array
			result = []
			# add planetIDs to the solarsystem data
			system.each do |a|
			
				tmp = a.as_json
				
				tmp['planetIDs'] = a.planets.pluck(:itemID)
				
				# push the result to the output
				result.push(tmp)
			end
			
			# return the output
			render json: result.as_json
      end
    end
  end
end
