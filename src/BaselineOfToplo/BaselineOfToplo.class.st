Class {
	#name : #BaselineOfToplo,
	#superclass : #BaselineOf,
	#classVars : [
		'Initialized'
	],
	#category : #BaselineOfToplo
}

{ #category : #baselines }
BaselineOfToplo >> baseline: spec [

	<baseline>
	spec for: #common do: [ self baselineForCommon: spec ]
]

{ #category : #baselines }
BaselineOfToplo >> baselineForCommon: spec [


	spec postLoadDoIt: #'postload:package:'.
	self dependencies: spec.
	self registerPackages: spec
]

{ #category : #dependencies }
BaselineOfToplo >> dependencies: spec [

	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://pharo-graphics/Bloc:master/src' ].

	spec
		baseline: 'Album'
		with: [ spec repository: 'github://pharo-graphics/Album:master/src' ]
]

{ #category : #baselines }
BaselineOfToplo >> postload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized = true ifTrue: [ ^ self ].
	" Install additional space phases "
	
	
	Initialized := true
]

{ #category : #baselines }
BaselineOfToplo >> registerPackages: spec [
	"Core"

	spec package: #Toplo with: [ spec requires: #( #Bloc ) ].
	spec package: #'Toplo-Tests' with: [ spec requires: #( #Toplo ) ].

	spec package: #'Toplo-Theme' with: [ spec requires: #( #Toplo ) ].
	spec
		package: #'Toplo-Theme-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Theme' ) ].

	spec package: #'Toplo-Widget-Album' with: [
		spec requires:
			#( #Toplo #Album #'Toplo-Widget-List' #'Toplo-Widget-Pane' ) ].

	spec
		package: #'Toplo-Widget-Album-Tests'
		with: [ spec requires: #( #'Toplo-Widget-Album' ) ].

	spec
		package: #'Toplo-Widget-Button'
		with: [
		spec requires: #( #Toplo #'Toplo-Widget-Image' #'Toplo-Theme' ) ].

	spec
		package: #'Toplo-Widget-Empty'
		with: [ spec requires: #( #Toplo ) ].

	spec
		package: #'Toplo-Widget-Button-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Button' ) ].

	spec package: #'Toplo-Widget-Accordion' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Button' #'Toplo-Widget-List'
			   #'Toplo-Theme' ) ].

	spec
		package: #'Toplo-Widget-Image'
		with: [ spec requires: #( #Toplo #'Toplo-Theme' ) ].

	spec
		package: #'Toplo-Widget-Image-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Image' ) ].

	spec package: #'Toplo-Widget-InnerWindow' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button'
			   #'Toplo-Widget-Image' #'Toplo-Widget-Pane' #'Toplo-Theme' ) ].

	spec package: #'Toplo-Widget-List' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Pane' #'Toplo-Widget-Button'
			   #'Toplo-Theme' ) ].

	spec
		package: #'Toplo-Widget-List-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-List' ) ].

	spec package: #'Toplo-Widget-Menu' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Button' #'Toplo-Widget-List'
			   #'Toplo-Theme' ) ].

	spec
		package: #'Toplo-Widget-Menu-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Menu' ) ].

	spec
		package: #'Toplo-Widget-Pane'
		with: [ spec requires: #( #Toplo #'Toplo-Theme' ) ].

	"Incubator"
	spec package: #'Toplo-Incubator' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button'
			   #'Toplo-Widget-Image' #'Toplo-Theme' ) ].

	spec package: #'Toplo-Demo' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button'
			   #'Toplo-Widget-Image' #'Toplo-Widget-List' #'Toplo-Widget-Pane' ) ].

	spec package: #'Toplo-Examples' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button'
			   #'Toplo-Widget-Select' #'Toplo-Widget-Image'
			   #'Toplo-Widget-InnerWindow' #'Toplo-Widget-List'
			   #'Toplo-Widget-Menu' #'Toplo-Widget-Pane' #'Toplo-Widget-Segmented' ) ].

	spec package: #'Toplo-Widget-Select' with: [
		spec requires: #( #Toplo #'Toplo-Widget-List' #'Toplo-Widget-Album'
			   #'Toplo-Widget-Button' #'Toplo-Widget-Image'
			   #'Toplo-Widget-Menu' #'Toplo-Widget-Tag' #'Toplo-Theme' ) ].

	spec
		package: #'Toplo-Widget-Select-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Select' ) ].

	spec
		package: #'Toplo-Widget-TabPane'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Pane' ) ].

	spec package: #'Toplo-Widget-Segmented' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Button' #'Toplo-Widget-List' ) ].

	spec package: #'Toplo-Widget-Tag' with: [
		spec requires:
			#( #Toplo #'Toplo-Widget-Button' #'Toplo-Widget-List' ) ].

	spec
		package: #'Toplo-Widget-TabPane-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-TabPane' ) ].

	spec package: #'Toplo-Theme-Bee' with: [
		spec requires:
			#( #'Toplo-Theme' #'Toplo-Widget-Button' #'Toplo-Widget-Album'
			   #'Toplo-Widget-Image' #'Toplo-Widget-Pane' ) ].

	spec
		package: #'Toplo-Theme-Bee-Tests'
		with: [ spec requires: #( #Toplo #'Toplo-Theme-Bee' ) ].

	spec
		package: #'Toplo-Theme-Examples'
		with: [ spec requires: #( #'Toplo-Theme-Bee' ) ].

	spec
		package: #'Toplo-Imported-Icons-AntDesign'
		with: [ spec requires: #(  ) ].

	spec
		package: #'Toplo-Imported-Icons-MaterialDesign'
		with: [ spec requires: #(  ) ]
]
