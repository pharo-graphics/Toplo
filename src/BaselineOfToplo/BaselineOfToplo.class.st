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

			spec package: 'Toplo-Theme'.

			spec package: 'Toplo-Theme-Tests'.

			spec package: 'Toplo-Widget-Empty-Tests'.

			spec package: 'Toplo-Widget-Float-Tests'.

			"Cycles ignored ('Toplo-Widget-Image')"
			spec
				package: 'Toplo-Widget-Image-Tests'
				with: [ spec requires: #('Bloc') ].

			"Cycles ignored ('Toplo-Imported-Icons-MaterialDesign' 'Toplo-Widget-Album' 'Toplo-Widget-Button' 'Toplo-Widget-Float' 'Toplo-Widget-Image' 'Toplo-Widget-InnerWindow' 'Toplo-Widget-List' 'Toplo-Widget-Menu' 'Toplo-Widget-Pane')"
			spec
				package: 'Toplo'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Toplo-Imported-Icons-AntDesign'
				with: [ spec requires: #('Toplo') ].

			spec
				package: 'Toplo-Imported-Icons-MaterialDesign'
				with: [ spec requires: #('Toplo') ].

			spec
				package: 'Toplo-Incubator'
				with: [ spec requires: #('Bloc' 'Toplo') ].

			spec
				package: 'Toplo-Widget-Image'
				with: [ spec requires: #('Bloc' 'Toplo') ].

			"Cycles ignored ('Toplo-Widget-Album')"
			spec
				package: 'Toplo-Widget-Diff'
				with: [ spec requires: #('Album' 'Bloc' 'Toplo') ].

			"Cycles ignored ('Toplo-Widget-Album')"
			spec
				package: 'Toplo-Widget-Empty'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Widget-Image') ].

			"Cycles ignored ('Toplo-Widget-Album')"
			spec
				package: 'Toplo-Widget-Float'
				with: [ spec requires: #('Bloc' 'Toplo') ].

			spec
				package: 'Toplo-Widget-Pane'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Imported-Icons-MaterialDesign'
					'Toplo-Widget-Empty'
					'Toplo-Widget-Float') ].

			"Cycles ignored ('Toplo-Widget-List')"
			spec
				package: 'Toplo-Widget-Button'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Imported-Icons-MaterialDesign'
					'Toplo-Widget-Image'
					'Toplo-Widget-Pane') ].

			"Cycles ignored ('Toplo-Widget-Album')"
			spec
				package: 'Toplo-Theme-Bee'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Widget-Button'
					'Toplo-Widget-Image'
					'Toplo-Widget-Pane') ].

			"Cycles ignored ('Toplo-Widget-Album')"
			spec
				package: 'Toplo-Widget-InnerWindow'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Imported-Icons-MaterialDesign'
					'Toplo-Widget-Button'
					'Toplo-Widget-Pane') ].

			"Cycles ignored ('Toplo-Widget-Album' 'Toplo-Widget-Menu')"
			spec
				package: 'Toplo-Widget-List'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Widget-Button' 'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Widget-Album'
				with: [ spec requires: #('Album' 'Bloc' 'Toplo' 'Toplo-Widget-List' 'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Widget-Accordion'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-List') ].

			spec
				package: 'Toplo-Widget-Menu'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Widget-Button'
					'Toplo-Widget-Image'
					'Toplo-Widget-List') ].

			spec
				package: 'Toplo-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Theme-Bee'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-Image'
					'Toplo-Widget-List'
					'Toplo-Widget-Menu'
					'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Demo'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Tests'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-Image'
					'Toplo-Widget-List'
					'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Theme-Bee-Tests'
				with: [ spec requires: #(
					'Toplo'
					'Toplo-Tests'
					'Toplo-Theme-Bee'
					'Toplo-Widget-Button') ].

			spec
				package: 'Toplo-Theme-Examples'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Theme-Bee'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-List'
					'Toplo-Widget-Menu') ].

			spec
				package: 'Toplo-Widget-Album-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Tests'
					'Toplo-Widget-Album'
					'Toplo-Widget-List') ].

			spec
				package: 'Toplo-Widget-Button-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Tests'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-Image'
					'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Widget-List-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Tests'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-List'
					'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Widget-Menu-Tests'
				with: [ spec requires: #('Toplo-Tests' 'Toplo-Widget-List' 'Toplo-Widget-Menu') ].

			spec
				package: 'Toplo-Widget-TabPane'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Imported-Icons-MaterialDesign'
					'Toplo-Widget-Button'
					'Toplo-Widget-List'
					'Toplo-Widget-Menu'
					'Toplo-Widget-Pane') ].

			spec
				package: 'Toplo-Widget-TabPane-Tests'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Tests' 'Toplo-Widget-TabPane') ].

			spec
				package: 'Toplo-Widget-Tag'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Widget-Button' 'Toplo-Widget-List') ].

			spec
				package: 'Toplo-Widget-Select'
				with: [ spec requires: #(
					'Album'
					'Bloc'
					'Toplo'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-List'
					'Toplo-Widget-Tag') ].

			spec
				package: 'Toplo-Widget-Select-Tests'
				with: [ spec requires: #(
					'Toplo'
					'Toplo-Tests'
					'Toplo-Theme-Bee'
					'Toplo-Widget-Album'
					'Toplo-Widget-Select') ].

			spec
				package: 'Toplo-Widget-Tree'
				with: [ spec requires: #('Bloc' 'Toplo' 'Toplo-Widget-Button' 'Toplo-Widget-List') ].

			spec
				package: 'Toplo-Widget-Table'
				with: [ spec requires: #(
					'Bloc'
					'Toplo'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-List'
					'Toplo-Widget-Pane'
					'Toplo-Widget-Tree') ].

			spec
				package: 'Toplo-Examples'
				with: [ spec requires: #(
					'Album'
					'Bloc'
					'Toplo'
					'Toplo-Imported-Icons-AntDesign'
					'Toplo-Imported-Icons-MaterialDesign'
					'Toplo-Incubator'
					'Toplo-Theme-Bee'
					'Toplo-Widget-Accordion'
					'Toplo-Widget-Album'
					'Toplo-Widget-Button'
					'Toplo-Widget-Diff'
					'Toplo-Widget-Empty'
					'Toplo-Widget-Float'
					'Toplo-Widget-Image'
					'Toplo-Widget-InnerWindow'
					'Toplo-Widget-List'
					'Toplo-Widget-Menu'
					'Toplo-Widget-Pane'
					'Toplo-Widget-Select'
					'Toplo-Widget-TabPane'
					'Toplo-Widget-Table'
					'Toplo-Widget-Tag'
					'Toplo-Widget-Tree') ].

			spec
				package: 'Toplo-Widget-Table-Tests'
				with: [ spec requires: #('Toplo-Tests' 'Toplo-Widget-Table') ].

			spec
				package: 'Toplo-Widget-Tree-Tests'
				with: [ spec requires: #('Toplo-Tests' 'Toplo-Widget-List' 'Toplo-Widget-Tree') ] ]
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
