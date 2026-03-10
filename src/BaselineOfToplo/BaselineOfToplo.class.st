Class {
	#name : #BaselineOfToplo,
	#superclass : #BaselineOf,
	#category : #BaselineOfToplo
}

{ #category : #baselines }
BaselineOfToplo >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [ 
			self
				declareAlbumOn: spec;
				declareBlocOn: spec.

			spec
				package: 'Toplo'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Toplo-Incubator'
				with: [ spec requires: #('Bloc' 'Toplo') ].

			spec
				package: 'Toplo-Theme'
				with: [ spec requires: #('Bloc' 'Toplo') ].

			spec
				package: 'Toplo-Widget'
				with: [ spec requires: #('Album' 'Bloc' 'Toplo' 'Toplo-Theme') ].

			spec
				package: 'Toplo-Theme-Bee'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Theme' 'Toplo-Widget') ].

			spec
				package: 'Toplo-Examples'
				with: [ spec requires: #(
					'Album'
					'Bloc'
					'Toplo'
					'Toplo-Incubator'
					'Toplo-Theme'
					'Toplo-Theme-Bee'
					'Toplo-Widget') ].

			spec
				package: 'Toplo-Tests'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Theme' 'Toplo-Theme-Bee' 'Toplo-Widget') ].

			spec
				package: 'Toplo-Demo'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Tests' 'Toplo-Theme' 'Toplo-Widget') ].

			spec
				package: 'Toplo-Theme-Bee-Tests'
				with: [ spec requires: #(
					'Toplo'
					'Toplo-Tests'
					'Toplo-Theme'
					'Toplo-Theme-Bee'
					'Toplo-Widget') ].

			spec
				package: 'Toplo-Theme-Examples'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Theme' 'Toplo-Theme-Bee' 'Toplo-Widget') ].

			spec
				package: 'Toplo-Widget-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Tests'
					'Toplo-Theme'
					'Toplo-Theme-Bee'
					'Toplo-Widget') ] ]
]

{ #category : #'external projects' }
BaselineOfToplo >> declareAlbumOn: spec [

	spec
		baseline: 'Album'
		with: [ spec repository: 'github://pharo-graphics/Album:master/src' ]
]

{ #category : #'external projects' }
BaselineOfToplo >> declareBlocOn: spec [

	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://pharo-graphics/Bloc:master/src' ]
]
