# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160304011625) do

  create_table "agtAgentTypes", primary_key: "agentTypeID", force: :cascade do |t|
    t.string "agentType", limit: 50
  end

  create_table "agtAgents", primary_key: "agentID", force: :cascade do |t|
    t.integer "divisionID",    limit: 1, unsigned: true
    t.integer "corporationID", limit: 4
    t.integer "locationID",    limit: 4
    t.integer "level",         limit: 1, unsigned: true
    t.integer "quality",       limit: 2
    t.integer "agentTypeID",   limit: 4
    t.boolean "isLocator",     limit: 1
  end

  add_index "agtagents", ["corporationID"], name: "agtAgents_IX_corporation", using: :btree
  add_index "agtagents", ["locationID"], name: "agtAgents_IX_station", using: :btree

  create_table "agtResearchAgents", id: false, force: :cascade do |t|
    t.integer "agentID", limit: 4, null: false
    t.integer "typeID",  limit: 4, null: false
  end

  add_index "agtresearchagents", ["typeID"], name: "agtResearchAgents_IX_type", using: :btree

  create_table "certCerts", primary_key: "certID", force: :cascade do |t|
    t.text    "description", limit: 4294967295
    t.integer "groupID",     limit: 4
    t.string  "name",        limit: 255
  end

  create_table "certMasteries", id: false, force: :cascade do |t|
    t.integer "typeID",       limit: 4
    t.integer "masteryLevel", limit: 4
    t.integer "certID",       limit: 4
  end

  create_table "certSkills", id: false, force: :cascade do |t|
    t.integer "certID",        limit: 4
    t.integer "skillID",       limit: 4
    t.integer "certLevelInt",  limit: 4
    t.integer "skillLevel",    limit: 4
    t.string  "certLevelText", limit: 8
  end

  add_index "certskills", ["certID"], name: "ix_certSkills_certID", using: :btree

  create_table "chrAncestries", primary_key: "ancestryID", force: :cascade do |t|
    t.string  "ancestryName",     limit: 100
    t.integer "bloodlineID",      limit: 1,    unsigned: true
    t.string  "description",      limit: 1000
    t.integer "perception",       limit: 1,    unsigned: true
    t.integer "willpower",        limit: 1,    unsigned: true
    t.integer "charisma",         limit: 1,    unsigned: true
    t.integer "memory",           limit: 1,    unsigned: true
    t.integer "intelligence",     limit: 1,    unsigned: true
    t.integer "iconID",           limit: 4
    t.string  "shortDescription", limit: 500
  end

  create_table "chrAttributes", primary_key: "attributeID", force: :cascade do |t|
    t.string  "attributeName",    limit: 100
    t.string  "description",      limit: 1000
    t.integer "iconID",           limit: 4
    t.string  "shortDescription", limit: 500
    t.string  "notes",            limit: 500
  end

  create_table "chrBloodlines", primary_key: "bloodlineID", force: :cascade do |t|
    t.string  "bloodlineName",          limit: 100
    t.integer "raceID",                 limit: 1,    unsigned: true
    t.string  "description",            limit: 1000
    t.string  "maleDescription",        limit: 1000
    t.string  "femaleDescription",      limit: 1000
    t.integer "shipTypeID",             limit: 4
    t.integer "corporationID",          limit: 4
    t.integer "perception",             limit: 1,    unsigned: true
    t.integer "willpower",              limit: 1,    unsigned: true
    t.integer "charisma",               limit: 1,    unsigned: true
    t.integer "memory",                 limit: 1,    unsigned: true
    t.integer "intelligence",           limit: 1,    unsigned: true
    t.integer "iconID",                 limit: 4
    t.string  "shortDescription",       limit: 500
    t.string  "shortMaleDescription",   limit: 500
    t.string  "shortFemaleDescription", limit: 500
  end

  create_table "chrFactions", primary_key: "factionID", force: :cascade do |t|
    t.string  "factionName",          limit: 100
    t.string  "description",          limit: 1000
    t.integer "raceIDs",              limit: 4
    t.integer "solarSystemID",        limit: 4
    t.integer "corporationID",        limit: 4
    t.float   "sizeFactor",           limit: 53
    t.integer "stationCount",         limit: 2
    t.integer "stationSystemCount",   limit: 2
    t.integer "militiaCorporationID", limit: 4
    t.integer "iconID",               limit: 4
  end

  create_table "chrRaces", primary_key: "raceID", force: :cascade do |t|
    t.string  "raceName",         limit: 100
    t.string  "description",      limit: 1000
    t.integer "iconID",           limit: 4
    t.string  "shortDescription", limit: 500
  end

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",            limit: 255,   null: false
    t.text     "log",               limit: 65535
    t.datetime "last_performed_at"
    t.boolean  "healthy",           limit: 1
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "crono_jobs", ["job_id"], name: "index_crono_jobs_on_job_id", unique: true, using: :btree

  create_table "crpActivities", primary_key: "activityID", force: :cascade do |t|
    t.string "activityName", limit: 100
    t.string "description",  limit: 1000
  end

  create_table "crpNPCCorporationDivisions", id: false, force: :cascade do |t|
    t.integer "corporationID", limit: 4, null: false
    t.integer "divisionID",    limit: 1, null: false, unsigned: true
    t.integer "size",          limit: 1,              unsigned: true
  end

  create_table "crpNPCCorporationResearchFields", id: false, force: :cascade do |t|
    t.integer "skillID",       limit: 4, null: false
    t.integer "corporationID", limit: 4, null: false
  end

  create_table "crpNPCCorporationTrades", id: false, force: :cascade do |t|
    t.integer "corporationID", limit: 4, null: false
    t.integer "typeID",        limit: 4, null: false
  end

  create_table "crpNPCCorporations", primary_key: "corporationID", force: :cascade do |t|
    t.string  "size",               limit: 1
    t.string  "extent",             limit: 1
    t.integer "solarSystemID",      limit: 4
    t.integer "investorID1",        limit: 4
    t.integer "investorShares1",    limit: 1,    unsigned: true
    t.integer "investorID2",        limit: 4
    t.integer "investorShares2",    limit: 1,    unsigned: true
    t.integer "investorID3",        limit: 4
    t.integer "investorShares3",    limit: 1,    unsigned: true
    t.integer "investorID4",        limit: 4
    t.integer "investorShares4",    limit: 1,    unsigned: true
    t.integer "friendID",           limit: 4
    t.integer "enemyID",            limit: 4
    t.integer "publicShares",       limit: 8
    t.integer "initialPrice",       limit: 4
    t.float   "minSecurity",        limit: 53
    t.boolean "scattered",          limit: 1
    t.integer "fringe",             limit: 1,    unsigned: true
    t.integer "corridor",           limit: 1,    unsigned: true
    t.integer "hub",                limit: 1,    unsigned: true
    t.integer "border",             limit: 1,    unsigned: true
    t.integer "factionID",          limit: 4
    t.float   "sizeFactor",         limit: 53
    t.integer "stationCount",       limit: 2
    t.integer "stationSystemCount", limit: 2
    t.string  "description",        limit: 4000
    t.integer "iconID",             limit: 4
  end

  create_table "crpNPCDivisions", primary_key: "divisionID", force: :cascade do |t|
    t.string "divisionName", limit: 100
    t.string "description",  limit: 1000
    t.string "leaderType",   limit: 100
  end

  create_table "dgmAttributeCategories", primary_key: "categoryID", force: :cascade do |t|
    t.string "categoryName",        limit: 50
    t.string "categoryDescription", limit: 200
  end

  create_table "dgmAttributeTypes", primary_key: "attributeID", force: :cascade do |t|
    t.string  "attributeName", limit: 100
    t.string  "description",   limit: 1000
    t.integer "iconID",        limit: 4
    t.float   "defaultValue",  limit: 53
    t.boolean "published",     limit: 1
    t.string  "displayName",   limit: 100
    t.integer "unitID",        limit: 1,    unsigned: true
    t.boolean "stackable",     limit: 1
    t.boolean "highIsGood",    limit: 1
    t.integer "categoryID",    limit: 1,    unsigned: true
  end

  create_table "dgmEffects", primary_key: "effectID", force: :cascade do |t|
    t.string  "effectName",                     limit: 400
    t.integer "effectCategory",                 limit: 2
    t.integer "preExpression",                  limit: 4
    t.integer "postExpression",                 limit: 4
    t.string  "description",                    limit: 1000
    t.string  "guid",                           limit: 60
    t.integer "iconID",                         limit: 4
    t.boolean "isOffensive",                    limit: 1
    t.boolean "isAssistance",                   limit: 1
    t.integer "durationAttributeID",            limit: 2
    t.integer "trackingSpeedAttributeID",       limit: 2
    t.integer "dischargeAttributeID",           limit: 2
    t.integer "rangeAttributeID",               limit: 2
    t.integer "falloffAttributeID",             limit: 2
    t.boolean "disallowAutoRepeat",             limit: 1
    t.boolean "published",                      limit: 1
    t.string  "displayName",                    limit: 100
    t.boolean "isWarpSafe",                     limit: 1
    t.boolean "rangeChance",                    limit: 1
    t.boolean "electronicChance",               limit: 1
    t.boolean "propulsionChance",               limit: 1
    t.integer "distribution",                   limit: 1,          unsigned: true
    t.string  "sfxName",                        limit: 20
    t.integer "npcUsageChanceAttributeID",      limit: 2
    t.integer "npcActivationChanceAttributeID", limit: 2
    t.integer "fittingUsageChanceAttributeID",  limit: 2
    t.text    "modifierInfo",                   limit: 4294967295
  end

  create_table "dgmExpressions", primary_key: "expressionID", force: :cascade do |t|
    t.integer "operandID",             limit: 4
    t.integer "arg1",                  limit: 4
    t.integer "arg2",                  limit: 4
    t.string  "expressionValue",       limit: 100
    t.string  "description",           limit: 1000
    t.string  "expressionName",        limit: 500
    t.integer "expressionTypeID",      limit: 4
    t.integer "expressionGroupID",     limit: 2
    t.integer "expressionAttributeID", limit: 2
  end

  create_table "dgmTypeAttributes", id: false, force: :cascade do |t|
    t.integer "typeID",      limit: 4,  null: false
    t.integer "attributeID", limit: 2,  null: false
    t.integer "valueInt",    limit: 4
    t.float   "valueFloat",  limit: 53
  end

  create_table "dgmTypeEffects", id: false, force: :cascade do |t|
    t.integer "typeID",    limit: 4, null: false
    t.integer "effectID",  limit: 2, null: false
    t.boolean "isDefault", limit: 1
  end

  create_table "eveGraphics", primary_key: "graphicID", force: :cascade do |t|
    t.string "sofFactionName", limit: 100
    t.string "graphicFile",    limit: 100
    t.string "sofHullName",    limit: 100
    t.string "sofRaceName",    limit: 100
    t.text   "description",    limit: 4294967295
  end

  create_table "eveIcons", primary_key: "iconID", force: :cascade do |t|
    t.string "iconFile",    limit: 500
    t.text   "description", limit: 4294967295
  end

  create_table "eveUnits", primary_key: "unitID", force: :cascade do |t|
    t.string "unitName",    limit: 100
    t.string "displayName", limit: 50
    t.string "description", limit: 1000
  end

  create_table "industryActivity", id: false, force: :cascade do |t|
    t.integer "typeID",     limit: 4, null: false
    t.integer "activityID", limit: 4, null: false
    t.integer "time",       limit: 4
  end

  add_index "industryactivity", ["activityID"], name: "ix_industryActivity_activityID", using: :btree

  create_table "industryActivityMaterials", id: false, force: :cascade do |t|
    t.integer "typeID",         limit: 4
    t.integer "activityID",     limit: 4
    t.integer "materialTypeID", limit: 4
    t.integer "quantity",       limit: 4
  end

  add_index "industryactivitymaterials", ["typeID", "activityID"], name: "industryActivityMaterials_idx1", using: :btree
  add_index "industryactivitymaterials", ["typeID"], name: "ix_industryActivityMaterials_typeID", using: :btree

  create_table "industryActivityProbabilities", id: false, force: :cascade do |t|
    t.integer "typeID",        limit: 4
    t.integer "activityID",    limit: 4
    t.integer "productTypeID", limit: 4
    t.decimal "probability",             precision: 3, scale: 2
  end

  add_index "industryactivityprobabilities", ["productTypeID"], name: "ix_industryActivityProbabilities_productTypeID", using: :btree
  add_index "industryactivityprobabilities", ["typeID"], name: "ix_industryActivityProbabilities_typeID", using: :btree

  create_table "industryActivityProducts", id: false, force: :cascade do |t|
    t.integer "typeID",        limit: 4
    t.integer "activityID",    limit: 4
    t.integer "productTypeID", limit: 4
    t.integer "quantity",      limit: 4
  end

  add_index "industryactivityproducts", ["productTypeID"], name: "ix_industryActivityProducts_productTypeID", using: :btree
  add_index "industryactivityproducts", ["typeID", "activityID"], name: "industryActivityProduct_idx1", using: :btree
  add_index "industryactivityproducts", ["typeID"], name: "ix_industryActivityProducts_typeID", using: :btree

  create_table "industryActivitySkills", id: false, force: :cascade do |t|
    t.integer "typeID",     limit: 4
    t.integer "activityID", limit: 4
    t.integer "skillID",    limit: 4
    t.integer "level",      limit: 4
  end

  add_index "industryactivityskills", ["skillID"], name: "ix_industryActivitySkills_skillID", using: :btree
  add_index "industryactivityskills", ["typeID", "activityID"], name: "industryActivitySkills_idx1", using: :btree
  add_index "industryactivityskills", ["typeID"], name: "ix_industryActivitySkills_typeID", using: :btree

  create_table "industryBlueprints", primary_key: "typeID", force: :cascade do |t|
    t.integer "maxProductionLimit", limit: 4
  end

  create_table "invCategories", primary_key: "categoryID", force: :cascade do |t|
    t.string  "categoryName", limit: 100
    t.integer "iconID",       limit: 8
    t.boolean "published",    limit: 1
  end

  create_table "invContrabandTypes", id: false, force: :cascade do |t|
    t.integer "factionID",        limit: 4,  null: false
    t.integer "typeID",           limit: 4,  null: false
    t.float   "standingLoss",     limit: 53
    t.float   "confiscateMinSec", limit: 53
    t.float   "fineByValue",      limit: 53
    t.float   "attackMinSec",     limit: 53
  end

  add_index "invcontrabandtypes", ["typeID"], name: "invContrabandTypes_IX_type", using: :btree

  create_table "invControlTowerResourcePurposes", primary_key: "purpose", force: :cascade do |t|
    t.string "purposeText", limit: 100
  end

  create_table "invControlTowerResources", id: false, force: :cascade do |t|
    t.integer "controlTowerTypeID", limit: 4,  null: false
    t.integer "resourceTypeID",     limit: 4,  null: false
    t.integer "purpose",            limit: 1,               unsigned: true
    t.integer "quantity",           limit: 4
    t.float   "minSecurityLevel",   limit: 53
    t.integer "factionID",          limit: 4
  end

  create_table "invFlags", primary_key: "flagID", force: :cascade do |t|
    t.string  "flagName", limit: 200
    t.string  "flagText", limit: 100
    t.integer "orderID",  limit: 4
  end

  create_table "invGroups", primary_key: "groupID", force: :cascade do |t|
    t.integer "categoryID",           limit: 4
    t.string  "groupName",            limit: 100
    t.integer "iconID",               limit: 8
    t.boolean "useBasePrice",         limit: 1
    t.boolean "anchored",             limit: 1
    t.boolean "anchorable",           limit: 1
    t.boolean "fittableNonSingleton", limit: 1
    t.boolean "published",            limit: 1
  end

  add_index "invgroups", ["categoryID"], name: "invTypes_categoryid", using: :btree

  create_table "invItems", primary_key: "itemID", force: :cascade do |t|
    t.integer "typeID",     limit: 4, null: false
    t.integer "ownerID",    limit: 4, null: false
    t.integer "locationID", limit: 8, null: false
    t.integer "flagID",     limit: 2, null: false
    t.integer "quantity",   limit: 4, null: false
  end

  add_index "invitems", ["locationID"], name: "items_IX_Location", using: :btree
  add_index "invitems", ["ownerID", "locationID"], name: "items_IX_OwnerLocation", using: :btree

  create_table "invMarketGroups", primary_key: "marketGroupID", force: :cascade do |t|
    t.integer "parentGroupID",   limit: 4
    t.string  "marketGroupName", limit: 100
    t.string  "description",     limit: 3000
    t.integer "iconID",          limit: 4
    t.boolean "hasTypes",        limit: 1
  end

  create_table "invMetaGroups", primary_key: "metaGroupID", force: :cascade do |t|
    t.string  "metaGroupName", limit: 100
    t.string  "description",   limit: 1000
    t.integer "iconID",        limit: 4
  end

  create_table "invMetaTypes", primary_key: "typeID", force: :cascade do |t|
    t.integer "parentTypeID", limit: 4
    t.integer "metaGroupID",  limit: 2
  end

  create_table "invNames", primary_key: "itemID", force: :cascade do |t|
    t.string "itemName", limit: 200, null: false
  end

  create_table "invPositions", primary_key: "itemID", force: :cascade do |t|
    t.float "x",     limit: 53, default: 0.0, null: false
    t.float "y",     limit: 53, default: 0.0, null: false
    t.float "z",     limit: 53, default: 0.0, null: false
    t.float "yaw",   limit: 24
    t.float "pitch", limit: 24
    t.float "roll",  limit: 24
  end

  create_table "invTraits", primary_key: "traitID", force: :cascade do |t|
    t.integer "typeID",    limit: 4
    t.integer "skillID",   limit: 4
    t.float   "bonus",     limit: 53
    t.text    "bonusText", limit: 4294967295
    t.integer "unitID",    limit: 4
  end

  create_table "invTypeMaterials", id: false, force: :cascade do |t|
    t.integer "typeID",         limit: 4,             null: false
    t.integer "materialTypeID", limit: 4,             null: false
    t.integer "quantity",       limit: 4, default: 0, null: false
  end

  create_table "invTypeReactions", id: false, force: :cascade do |t|
    t.integer "reactionTypeID", limit: 4, null: false
    t.boolean "input",          limit: 1, null: false
    t.integer "typeID",         limit: 4, null: false
    t.integer "quantity",       limit: 2
  end

  create_table "invTypes", primary_key: "typeID", force: :cascade do |t|
    t.integer "groupID",       limit: 4
    t.string  "typeName",      limit: 100
    t.text    "description",   limit: 4294967295
    t.float   "mass",          limit: 53
    t.float   "volume",        limit: 53
    t.float   "capacity",      limit: 53
    t.integer "portionSize",   limit: 4
    t.integer "raceID",        limit: 2
    t.decimal "basePrice",                        precision: 19, scale: 4
    t.boolean "published",     limit: 1
    t.integer "marketGroupID", limit: 8
    t.integer "iconID",        limit: 8
    t.integer "soundID",       limit: 8
    t.integer "graphicID",     limit: 8
  end

  add_index "invtypes", ["groupID"], name: "invTypes_groupid", using: :btree

  create_table "invUniqueNames", primary_key: "itemID", force: :cascade do |t|
    t.string  "itemName", limit: 200, null: false
    t.integer "groupID",  limit: 4
  end

  add_index "invuniquenames", ["groupID", "itemName"], name: "invUniqueNames_IX_GroupName", using: :btree
  add_index "invuniquenames", ["itemName"], name: "invUniqueNames_UQ", unique: true, using: :btree

  create_table "item_history", force: :cascade do |t|
    t.integer  "typeID",     limit: 4,               unsigned: true
    t.integer  "orderCount", limit: 8,               unsigned: true
    t.float    "lowPrice",   limit: 24
    t.float    "highPrice",  limit: 24
    t.float    "avgPrice",   limit: 24
    t.integer  "volume",     limit: 8,               unsigned: true
    t.datetime "date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "item_history", ["typeID"], name: "index_item_history_on_typeID", using: :btree

  create_table "mapCelestialStatistics", primary_key: "celestialID", force: :cascade do |t|
    t.float   "temperature",    limit: 53
    t.string  "spectralClass",  limit: 10
    t.float   "luminosity",     limit: 53
    t.float   "age",            limit: 53
    t.float   "life",           limit: 53
    t.float   "orbitRadius",    limit: 53
    t.float   "eccentricity",   limit: 53
    t.float   "massDust",       limit: 53
    t.float   "massGas",        limit: 53
    t.integer "fragmented",     limit: 4
    t.float   "density",        limit: 53
    t.float   "surfaceGravity", limit: 53
    t.float   "escapeVelocity", limit: 53
    t.float   "orbitPeriod",    limit: 53
    t.float   "rotationRate",   limit: 53
    t.integer "locked",         limit: 4
    t.integer "pressure",       limit: 8
    t.integer "radius",         limit: 8
    t.integer "mass",           limit: 4
  end

  create_table "mapConstellationJumps", id: false, force: :cascade do |t|
    t.integer "fromRegionID",        limit: 8
    t.integer "fromConstellationID", limit: 8, null: false
    t.integer "toConstellationID",   limit: 8, null: false
    t.integer "toRegionID",          limit: 8
  end

  create_table "mapConstellations", primary_key: "constellationID", force: :cascade do |t|
    t.integer "regionID",          limit: 4
    t.string  "constellationName", limit: 100
    t.float   "x",                 limit: 53
    t.float   "y",                 limit: 53
    t.float   "z",                 limit: 53
    t.float   "xMin",              limit: 53
    t.float   "xMax",              limit: 53
    t.float   "yMin",              limit: 53
    t.float   "yMax",              limit: 53
    t.float   "zMin",              limit: 53
    t.float   "zMax",              limit: 53
    t.integer "factionID",         limit: 4
    t.float   "radius",            limit: 53
  end

  add_index "mapconstellations", ["regionID"], name: "mapConstellations_IX_region", using: :btree

  create_table "mapDenormalize", primary_key: "itemID", force: :cascade do |t|
    t.integer "typeID",          limit: 4
    t.integer "groupID",         limit: 4
    t.integer "solarSystemID",   limit: 4
    t.integer "constellationID", limit: 4
    t.integer "regionID",        limit: 4
    t.integer "orbitID",         limit: 4
    t.float   "x",               limit: 53
    t.float   "y",               limit: 53
    t.float   "z",               limit: 53
    t.float   "radius",          limit: 53
    t.string  "itemName",        limit: 100
    t.float   "security",        limit: 53
    t.integer "celestialIndex",  limit: 4
    t.integer "orbitIndex",      limit: 4
  end

  add_index "mapdenormalize", ["constellationID"], name: "mapDenormalize_IX_constellation", using: :btree
  add_index "mapdenormalize", ["groupID", "constellationID"], name: "mapDenormalize_IX_groupConstellation", using: :btree
  add_index "mapdenormalize", ["groupID", "regionID"], name: "mapDenormalize_IX_groupRegion", using: :btree
  add_index "mapdenormalize", ["groupID", "solarSystemID"], name: "mapDenormalize_IX_groupSystem", using: :btree
  add_index "mapdenormalize", ["orbitID"], name: "mapDenormalize_IX_orbit", using: :btree
  add_index "mapdenormalize", ["regionID"], name: "mapDenormalize_IX_region", using: :btree
  add_index "mapdenormalize", ["solarSystemID", "x", "y", "z", "itemName", "itemID"], name: "mapDenormalize_gis", length: {"solarSystemID"=>nil, "x"=>nil, "y"=>nil, "z"=>nil, "itemName"=>40, "itemID"=>nil}, using: :btree
  add_index "mapdenormalize", ["solarSystemID"], name: "mapDenormalize_IX_system", using: :btree

  create_table "mapJumps", primary_key: "stargateID", force: :cascade do |t|
    t.integer "destinationID", limit: 8
  end

  create_table "mapLandmarks", primary_key: "landmarkID", force: :cascade do |t|
    t.string  "landmarkName", limit: 100
    t.text    "description",  limit: 4294967295
    t.integer "locationID",   limit: 8
    t.float   "x",            limit: 53
    t.float   "y",            limit: 53
    t.float   "z",            limit: 53
    t.integer "iconID",       limit: 8
  end

  create_table "mapLocationScenes", primary_key: "locationID", force: :cascade do |t|
    t.integer "graphicID", limit: 4
  end

  create_table "mapLocationWormholeClasses", primary_key: "locationID", force: :cascade do |t|
    t.integer "wormholeClassID", limit: 4
  end

  create_table "mapRegionJumps", id: false, force: :cascade do |t|
    t.integer "fromRegionID", limit: 8, null: false
    t.integer "toRegionID",   limit: 8, null: false
  end

  create_table "mapRegions", primary_key: "regionID", force: :cascade do |t|
    t.string  "regionName", limit: 100
    t.float   "x",          limit: 53
    t.float   "y",          limit: 53
    t.float   "z",          limit: 53
    t.float   "xMin",       limit: 53
    t.float   "xMax",       limit: 53
    t.float   "yMin",       limit: 53
    t.float   "yMax",       limit: 53
    t.float   "zMin",       limit: 53
    t.float   "zMax",       limit: 53
    t.integer "factionID",  limit: 4
    t.float   "radius",     limit: 53
  end

  add_index "mapregions", ["regionID"], name: "mapRegions_IX_region", using: :btree

  create_table "mapSolarSystemJumps", id: false, force: :cascade do |t|
    t.integer "fromRegionID",        limit: 8
    t.integer "fromConstellationID", limit: 8
    t.integer "fromSolarSystemID",   limit: 8, null: false
    t.integer "toSolarSystemID",     limit: 8, null: false
    t.integer "toConstellationID",   limit: 8
    t.integer "toRegionID",          limit: 8
  end

  create_table "mapSolarSystems", primary_key: "solarSystemID", force: :cascade do |t|
    t.integer "regionID",        limit: 4
    t.integer "constellationID", limit: 4
    t.string  "solarSystemName", limit: 100
    t.float   "x",               limit: 53
    t.float   "y",               limit: 53
    t.float   "z",               limit: 53
    t.float   "xMin",            limit: 53
    t.float   "xMax",            limit: 53
    t.float   "yMin",            limit: 53
    t.float   "yMax",            limit: 53
    t.float   "zMin",            limit: 53
    t.float   "zMax",            limit: 53
    t.float   "luminosity",      limit: 53
    t.integer "border",          limit: 8
    t.integer "fringe",          limit: 8
    t.integer "corridor",        limit: 8
    t.integer "hub",             limit: 8
    t.integer "international",   limit: 8
    t.integer "regional",        limit: 8
    t.integer "constellation",   limit: 8
    t.float   "security",        limit: 53
    t.integer "factionID",       limit: 4
    t.float   "radius",          limit: 53
    t.integer "sunTypeID",       limit: 4
    t.string  "securityClass",   limit: 2
  end

  add_index "mapsolarsystems", ["constellationID"], name: "mapSolarSystems_IX_constellation", using: :btree
  add_index "mapsolarsystems", ["regionID"], name: "mapSolarSystems_IX_region", using: :btree
  add_index "mapsolarsystems", ["security"], name: "mapSolarSystems_IX_security", using: :btree
  add_index "mapsolarsystems", ["solarSystemName"], name: "mss_name", length: {"solarSystemName"=>40}, using: :btree

  create_table "mapUniverse", primary_key: "universeID", force: :cascade do |t|
    t.string "universeName", limit: 100
    t.float  "x",            limit: 53
    t.float  "y",            limit: 53
    t.float  "z",            limit: 53
    t.float  "xMin",         limit: 53
    t.float  "xMax",         limit: 53
    t.float  "yMin",         limit: 53
    t.float  "yMax",         limit: 53
    t.float  "zMin",         limit: 53
    t.float  "zMax",         limit: 53
    t.float  "radius",       limit: 53
  end

  create_table "map_jumps_current", force: :cascade do |t|
    t.integer  "solarSystemID", limit: 4
    t.integer  "shipJumps",     limit: 4
    t.datetime "cachedUntil"
  end

  create_table "map_jumps_history", force: :cascade do |t|
    t.integer  "solarSystemID", limit: 4
    t.integer  "shipJumps",     limit: 4
    t.datetime "cachedUntil"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "map_kills_current", force: :cascade do |t|
    t.integer  "solarSystemID", limit: 4
    t.integer  "shipKills",     limit: 4
    t.integer  "factionKills",  limit: 4
    t.integer  "podKills",      limit: 4
    t.datetime "cachedUntil"
  end

  create_table "map_kills_history", force: :cascade do |t|
    t.integer  "solarSystemID", limit: 4
    t.integer  "shipKills",     limit: 4
    t.integer  "factionKills",  limit: 4
    t.integer  "podKills",      limit: 4
    t.datetime "cachedUntil"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "map_moons", primary_key: "moonID", force: :cascade do |t|
    t.integer "atm",  limit: 4, default: -1
    t.integer "eva",  limit: 4, default: -1
    t.integer "hyd",  limit: 4, default: -1
    t.integer "sil",  limit: 4, default: -1
    t.integer "cob",  limit: 4, default: -1
    t.integer "sca",  limit: 4, default: -1
    t.integer "tit",  limit: 4, default: -1
    t.integer "tun",  limit: 4, default: -1
    t.integer "cad",  limit: 4, default: -1
    t.integer "van",  limit: 4, default: -1
    t.integer "chr",  limit: 4, default: -1
    t.integer "pla",  limit: 4, default: -1
    t.integer "cae",  limit: 4, default: -1
    t.integer "tec",  limit: 4, default: -1
    t.integer "haf",  limit: 4, default: -1
    t.integer "mer",  limit: 4, default: -1
    t.integer "pro",  limit: 4, default: -1
    t.integer "dys",  limit: 4, default: -1
    t.integer "neo",  limit: 4, default: -1
    t.integer "thu",  limit: 4, default: -1
    t.integer "scan", limit: 4, default: -1
  end

  create_table "planetSchematics", primary_key: "schematicID", force: :cascade do |t|
    t.string  "schematicName", limit: 255
    t.integer "cycleTime",     limit: 4
  end

  create_table "planetSchematicsPinMap", id: false, force: :cascade do |t|
    t.integer "schematicID", limit: 2, null: false
    t.integer "pinTypeID",   limit: 4, null: false
  end

  create_table "planetSchematicsTypeMap", id: false, force: :cascade do |t|
    t.integer "schematicID", limit: 2, null: false
    t.integer "typeID",      limit: 4, null: false
    t.integer "quantity",    limit: 2
    t.boolean "isInput",     limit: 1
  end

  create_table "planet_materials", force: :cascade do |t|
    t.integer "typeID",       limit: 4
    t.string  "materialType", limit: 255
  end

  create_table "player_stations", force: :cascade do |t|
    t.integer  "stationID",       limit: 4
    t.string   "stationName",     limit: 255
    t.integer  "stationTypeID",   limit: 4
    t.integer  "solarSystemID",   limit: 4
    t.integer  "corporationID",   limit: 4
    t.string   "corporationName", limit: 255
    t.float    "x",               limit: 24
    t.float    "y",               limit: 24
    t.float    "z",               limit: 24
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "ramActivities", primary_key: "activityID", force: :cascade do |t|
    t.string  "activityName", limit: 100
    t.string  "iconNo",       limit: 5
    t.string  "description",  limit: 1000
    t.boolean "published",    limit: 1
  end

  create_table "ramAssemblyLineStations", id: false, force: :cascade do |t|
    t.integer "stationID",          limit: 4, null: false
    t.integer "assemblyLineTypeID", limit: 1, null: false, unsigned: true
    t.integer "quantity",           limit: 1,              unsigned: true
    t.integer "stationTypeID",      limit: 4
    t.integer "ownerID",            limit: 4
    t.integer "solarSystemID",      limit: 4
    t.integer "regionID",           limit: 4
  end

  add_index "ramassemblylinestations", ["ownerID"], name: "ramAssemblyLineStations_IX_owner", using: :btree
  add_index "ramassemblylinestations", ["regionID"], name: "ramAssemblyLineStations_IX_region", using: :btree

  create_table "ramAssemblyLineTypeDetailPerCategory", id: false, force: :cascade do |t|
    t.integer "assemblyLineTypeID", limit: 1,  null: false, unsigned: true
    t.integer "categoryID",         limit: 4,  null: false
    t.float   "timeMultiplier",     limit: 53
    t.float   "materialMultiplier", limit: 53
    t.float   "costMultiplier",     limit: 53
  end

  create_table "ramAssemblyLineTypeDetailPerGroup", id: false, force: :cascade do |t|
    t.integer "assemblyLineTypeID", limit: 1,  null: false, unsigned: true
    t.integer "groupID",            limit: 4,  null: false
    t.float   "timeMultiplier",     limit: 53
    t.float   "materialMultiplier", limit: 53
    t.float   "costMultiplier",     limit: 53
  end

  create_table "ramAssemblyLineTypes", primary_key: "assemblyLineTypeID", force: :cascade do |t|
    t.string  "assemblyLineTypeName",   limit: 100
    t.string  "description",            limit: 1000
    t.float   "baseTimeMultiplier",     limit: 53
    t.float   "baseMaterialMultiplier", limit: 53
    t.float   "baseCostMultiplier",     limit: 53
    t.float   "volume",                 limit: 53
    t.integer "activityID",             limit: 1,    unsigned: true
    t.float   "minCostPerHour",         limit: 53
  end

  create_table "ramInstallationTypeContents", id: false, force: :cascade do |t|
    t.integer "installationTypeID", limit: 4, null: false
    t.integer "assemblyLineTypeID", limit: 1, null: false, unsigned: true
    t.integer "quantity",           limit: 1,              unsigned: true
  end

  create_table "skinLicense", primary_key: "licenseTypeID", force: :cascade do |t|
    t.integer "duration", limit: 4
    t.integer "skinID",   limit: 4
  end

  create_table "skinMaterials", primary_key: "skinMaterialID", force: :cascade do |t|
    t.integer "displayNameID", limit: 4
    t.integer "materialSetID", limit: 4
  end

  create_table "skinShip", id: false, force: :cascade do |t|
    t.integer "skinID", limit: 4
    t.integer "typeID", limit: 4
  end

  add_index "skinship", ["skinID"], name: "ix_skinShip_skinID", using: :btree
  add_index "skinship", ["typeID"], name: "ix_skinShip_typeID", using: :btree

  create_table "skins", primary_key: "skinID", force: :cascade do |t|
    t.string  "internalName",   limit: 70
    t.integer "skinMaterialID", limit: 4
  end

  create_table "sovStructures", force: :cascade do |t|
    t.integer  "solarSystemID",       limit: 4
    t.integer  "allianceID",          limit: 4
    t.float    "occupancyLevel",      limit: 24
    t.integer  "structureID",         limit: 8
    t.integer  "structureTypeID",     limit: 4
    t.datetime "vulnerableStartTime"
    t.datetime "vulnerableEndTime"
  end

  create_table "staOperationServices", id: false, force: :cascade do |t|
    t.integer "operationID", limit: 1, null: false, unsigned: true
    t.integer "serviceID",   limit: 4, null: false
  end

  create_table "staOperations", primary_key: "operationID", force: :cascade do |t|
    t.integer "activityID",            limit: 1,    unsigned: true
    t.string  "operationName",         limit: 100
    t.string  "description",           limit: 1000
    t.integer "fringe",                limit: 1,    unsigned: true
    t.integer "corridor",              limit: 1,    unsigned: true
    t.integer "hub",                   limit: 1,    unsigned: true
    t.integer "border",                limit: 1,    unsigned: true
    t.integer "ratio",                 limit: 1,    unsigned: true
    t.integer "caldariStationTypeID",  limit: 4
    t.integer "minmatarStationTypeID", limit: 4
    t.integer "amarrStationTypeID",    limit: 4
    t.integer "gallenteStationTypeID", limit: 4
    t.integer "joveStationTypeID",     limit: 4
  end

  create_table "staServices", primary_key: "serviceID", force: :cascade do |t|
    t.string "serviceName", limit: 100
    t.string "description", limit: 1000
  end

  create_table "staStationTypes", primary_key: "stationTypeID", force: :cascade do |t|
    t.float   "dockEntryX",             limit: 53
    t.float   "dockEntryY",             limit: 53
    t.float   "dockEntryZ",             limit: 53
    t.float   "dockOrientationX",       limit: 53
    t.float   "dockOrientationY",       limit: 53
    t.float   "dockOrientationZ",       limit: 53
    t.integer "operationID",            limit: 1,  unsigned: true
    t.integer "officeSlots",            limit: 1,  unsigned: true
    t.float   "reprocessingEfficiency", limit: 53
    t.boolean "conquerable",            limit: 1
  end

  create_table "staStations", primary_key: "stationID", force: :cascade do |t|
    t.integer "security",                 limit: 2
    t.float   "dockingCostPerVolume",     limit: 53
    t.float   "maxShipVolumeDockable",    limit: 53
    t.integer "officeRentalCost",         limit: 4
    t.integer "operationID",              limit: 1,   unsigned: true
    t.integer "stationTypeID",            limit: 4
    t.integer "corporationID",            limit: 4
    t.integer "solarSystemID",            limit: 4
    t.integer "constellationID",          limit: 4
    t.integer "regionID",                 limit: 4
    t.string  "stationName",              limit: 100
    t.float   "x",                        limit: 53
    t.float   "y",                        limit: 53
    t.float   "z",                        limit: 53
    t.float   "reprocessingEfficiency",   limit: 53
    t.float   "reprocessingStationsTake", limit: 53
    t.integer "reprocessingHangarFlag",   limit: 1,   unsigned: true
  end

  add_index "stastations", ["constellationID"], name: "staStations_IX_constellation", using: :btree
  add_index "stastations", ["corporationID"], name: "staStations_IX_corporation", using: :btree
  add_index "stastations", ["operationID"], name: "staStations_IX_operation", using: :btree
  add_index "stastations", ["regionID"], name: "staStations_IX_region", using: :btree
  add_index "stastations", ["solarSystemID"], name: "staStations_IX_system", using: :btree
  add_index "stastations", ["stationTypeID"], name: "staStations_IX_type", using: :btree

  create_table "system_cost_indices", force: :cascade do |t|
    t.integer "solarSystemID",         limit: 4
    t.string  "inventionIndex",        limit: 255
    t.string  "manufacturingIndex",    limit: 255
    t.string  "copyingIndex",          limit: 255
    t.string  "timeResearchIndex",     limit: 255
    t.string  "materialResearchIndex", limit: 255
  end

  create_table "translationTables", id: false, force: :cascade do |t|
    t.string  "sourceTable",      limit: 200, null: false
    t.string  "destinationTable", limit: 200
    t.string  "translatedKey",    limit: 200, null: false
    t.integer "tcGroupID",        limit: 4
    t.integer "tcID",             limit: 4
  end

  create_table "trnTranslationColumns", primary_key: "tcID", force: :cascade do |t|
    t.integer "tcGroupID",  limit: 2
    t.string  "tableName",  limit: 256, null: false
    t.string  "columnName", limit: 128, null: false
    t.string  "masterID",   limit: 128
  end

  create_table "trnTranslationLanguages", primary_key: "numericLanguageID", force: :cascade do |t|
    t.string "languageID",   limit: 50
    t.string "languageName", limit: 200
  end

  create_table "trnTranslations", id: false, force: :cascade do |t|
    t.integer "tcID",       limit: 2,          null: false
    t.integer "keyID",      limit: 4,          null: false
    t.string  "languageID", limit: 50,         null: false
    t.text    "text",       limit: 4294967295, null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "characterID",  limit: 4
    t.integer  "uid",          limit: 4
    t.string   "refreshToken", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name",         limit: 255
    t.string   "token",        limit: 255
    t.datetime "expiry"
  end

  add_index "users", ["characterID"], name: "index_users_on_characterID", unique: true, using: :btree

  create_table "warCombatZoneSystems", primary_key: "solarSystemID", force: :cascade do |t|
    t.integer "combatZoneID", limit: 4
  end

  create_table "warCombatZones", primary_key: "combatZoneID", force: :cascade do |t|
    t.string  "combatZoneName", limit: 100
    t.integer "factionID",      limit: 4
    t.integer "centerSystemID", limit: 4
    t.string  "description",    limit: 500
  end

  create_table "wormhole_effects", id: false, force: :cascade do |t|
    t.integer "effectID",      limit: 4
    t.string  "effectName",    limit: 255
    t.string  "wormholeClass", limit: 255
    t.string  "attributeName", limit: 255
    t.float   "effectValue",   limit: 24
  end

  create_table "wormhole_systems", id: false, force: :cascade do |t|
    t.integer "solarSystemID",      limit: 4
    t.string  "wormholeName",       limit: 255
    t.integer "wormholeClass",      limit: 4
    t.integer "wormHoleEffectName", limit: 4
    t.integer "static1",            limit: 4
    t.integer "static2",            limit: 4
  end

  create_table "wormhole_types", id: false, force: :cascade do |t|
    t.integer "wormholeID",   limit: 4
    t.string  "wormholeName", limit: 255
    t.string  "source",       limit: 255
    t.string  "destination",  limit: 255
    t.integer "lifeTime",     limit: 4
    t.integer "jumpMass",     limit: 4
    t.integer "maxMass",      limit: 4
  end

end
