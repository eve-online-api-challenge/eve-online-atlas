class SolarSystem < ActiveRecord::Base
  self.table_name = 'mapSolarSystems'
  self.primary_key = 'solarSystemID'
  belongs_to :region, foreign_key: 'regionID'
  belongs_to :constellation, foreign_key: 'constellationID'
  has_many :stations, foreign_key: 'solarSystemID'
  has_many :playerStations, foreign_key: 'solarSystemID'
  has_many :jumpsCurrents, foreign_key: 'solarSystemID'
  has_many :killsCurrents, foreign_key: 'solarSystemID'
  has_many :jumpsHistory, foreign_key: 'solarSystemID'
  has_many :killsHistory, foreign_key: 'solarSystemID'
  has_many :planets, foreign_key: 'solarSystemID'
  has_many :sovStructures, foreign_key: 'solarSystemID'
  has_one :systemCostIndex, foreign_key: 'solarSystemID'
  has_many :mapSolarSystemJumps, foreign_key: 'fromSolarSystemID'
  has_many :toSolarSystems, through: :mapSolarSystemJumps, foreign_key: 'toSolarSystemID'
end
