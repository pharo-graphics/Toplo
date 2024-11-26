Class {
	#name : #ToRelationShipWithSpaceEvent,
	#superclass : #BlEvent,
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToRelationShipWithSpaceEvent >> windowManager [

	^ windowManager 
]

{ #category : #accessing }
ToRelationShipWithSpaceEvent >> windowManager: anAnchoredWindowManager [

	windowManager := anAnchoredWindowManager 
]
