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
		with: [ spec repository: 'github://pharo-graphics/bloc:dev-1.0/src' ].

	spec
		baseline: 'Album'
		with: [ spec repository: 'github://plantec/Album/src' ]
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
	spec 
		package: #Toplo 
		with: [ spec requires: #( #Bloc ) ].
		
	spec 
		package: #'Toplo-Widget-Album' 
		with: [ spec requires: #( #Toplo #Album #Toplo-Widget-List #Toplo-Widget-Window #Toplo-Widget-Pane) ].
	spec 
		package: #'Toplo-Widget-Album-Skin' 
		with: [ spec requires: #( #Toplo #Toplo-Widget-Album) ].

	spec 
		package: #'Toplo-Widget-Button' 
		with: [ spec requires: #( #Toplo #Toplo-Widget-Window) ].
	spec 
		package: #'Toplo-Widget-Button-Skin' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album-Skin' #'Toplo-Widget-Image-Skin') ].
		
	spec 
		package: #'Toplo-Widget-Image' 
		with: [ spec requires: #( #Toplo ) ].
	spec 
		package: #'Toplo-Widget-Image-Skin' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Image' ) ].

	spec 
		package: #'Toplo-Widget-ChoiceBox' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button'  #'Toplo-Widget-Image' #'Toplo-Widget-Menu' ) ].
	spec 
		package: #'Toplo-Widget-ComboBox' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button' #'Toplo-Widget-Image' #'Toplo-Widget-List' #'Toplo-Widget-Pane' #'Toplo-Widget-Window'  ) ].
	spec 
		package: #'Toplo-Widget-List' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Pane' ) ].
	spec 
		package: #'Toplo-Widget-Menu' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Button' #'Toplo-Widget-Window' ) ].
	spec 
		package: #'Toplo-Widget-Menu-Skin' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Button-Skin' #'Toplo-Widget-Image' #'Toplo-Widget-Menu' ) ].
	spec 
		package: #'Toplo-Widget-Pane' 
		with: [ spec requires: #( #Toplo ) ].
	spec 
		package: #'Toplo-Widget-Pane-Skin' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Pane') ].
	spec 
		package: #'Toplo-Widget-Window' 
		with: [ spec requires: #( #Toplo ) ].
	spec 
		package: #'Toplo-Widget-InnerWindow' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button' #'Toplo-Widget-Image' #'Toplo-Widget-Pane' #'Toplo-Widget-Window') ].
	spec 
		package: #'Toplo-Widget-Tooltip' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Window' ) ].
	
	"Tests"
	spec 
		package: #'Toplo-Tests' 
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button' #'Toplo-Widget-ChoiceBox' #'Toplo-Widget-ComboBox' #'Toplo-Widget-Image' #'Toplo-Widget-List'#'Toplo-Widget-Pane'  ) ].
		
	"Incubator"
	spec
		package: #'Toplo-Incubator'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Button' #'Toplo-Widget-Image'  ) ].
		
	spec
		package: #'Toplo-Examples'
		with: [ spec requires: #( #Toplo #'Toplo-Widget-Album' #'Toplo-Widget-Album-Skin' #'Toplo-Widget-Button' #'Toplo-Widget-Button-Skin' #'Toplo-Widget-ChoiceBox' #'Toplo-Widget-ComboBox' #'Toplo-Widget-Image' #'Toplo-Widget-InnerWindow' #'Toplo-Widget-List' #'Toplo-Widget-Menu' #'Toplo-Widget-Pane' #'Toplo-Widget-Window' ) ].
		
	spec 
		package: #'Toplo-IDE' 
		with: [ spec requires: #( #Toplo #'Toplo-Examples' ) ].


		
	 



]
