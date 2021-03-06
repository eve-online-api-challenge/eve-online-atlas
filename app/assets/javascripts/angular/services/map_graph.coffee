app.factory 'mapGraph', ['$q', ($q) ->
  cy = undefined
  mapGraph = (solarSystems) =>
    deferred = $q.defer()
    sourceSystem = _.head(solarSystems)
    eles = _.map(solarSystems, (s) -> {classes: 'multiline-manual', group: 'nodes', data: {id: s.solarSystemID, label: s.solarSystemName + '\n(' + s.jumps.toString() + ', ' + s.shipKills.toString() + ', ' + s.podKills.toString() + ')'}})
    for system, idx in solarSystems
      if idx isnt 0
        eles.push {group: 'edges', data: {id: 'e' + idx.toString(), source: _.head(solarSystems).solarSystemID, target: system.solarSystemID}}
    $ =>
      # on dom ready
      cy = cytoscape(
        container: $('#map')[0]
        userPanningEnabled: false
        userZoomingEnabled: false
        boxSelectionEnabled: false
        autounselectify: true
        autoungrabify: true
        style: [
          {
            selector: 'node'
            style:
              'height': 80
              'width': 80
              'color': 'white'
              'text-outline-width': 2
              'text-outline-color': '#888'
              'label': 'data(label)'
              'text-valign': 'center'
          }
          {
            selector: '.multiline-manual'
            style: 'text-wrap': 'wrap'
          }
        ]
        layout:
          name: 'concentric'
          concentric: (node) ->
            return 200 if parseInt(node._private.data.id) == sourceSystem.solarSystemID
            return 1
        elements: eles
        ready: ->
          deferred.resolve(this)
      )
      return
    # on dom ready
    deferred.promise

  fire = (e, args) ->
    listeners = mapGraph.listeners[e]
    i = 0
    while listeners and i < listeners.length
      fn = listeners[i]
      fn.apply fn, args
      i++
    return

  listen = (e, fn) ->
    listeners = mapGraph.listeners[e] = mapGraph.listeners[e] or []
    listeners.push fn
    return

  mapGraph.listeners = {}

#  mapGraph.setPersonWeight = (id, weight) ->
#    cy.$('#' + id).data 'weight', weight
#    return

#  mapGraph.onWeightChange = (fn) ->
#    listen 'onWeightChange', fn
#    return

  return mapGraph
]

# ---
# generated by js2coffee 2.1.0