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
		with: [ spec requires: #( #Bloc #Album ) ].

	"IDE"
	spec 
		package: #'Toplo-IDE' 
		with: [ spec requires: #( #Toplo ) ].

	"Tests"
	spec 
		package: #'Toplo-Tests' 
		with: [ spec requires: #( #Toplo ) ].
		
	"Incubator"
	spec
		package: #'Toplo-Incubator'
		with: [ spec requires: #( #Toplo ) ].
]
