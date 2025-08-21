Class {
	#name : #ToAnchoredAtPerimeter,
	#superclass : #ToAnchoredPlacement,
	#instVars : [
		'radians',
		'pivotalElement'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #accessing }
ToAnchoredAtPerimeter >> around: aPivotalElement atDegrees: anAngleInDegrees [

	self pivotalElement: aPivotalElement.
	self degrees: anAngleInDegrees
]

{ #category : #accessing }
ToAnchoredAtPerimeter >> around: aPivotalElement atRadians: anAngleInRadians [

	self pivotalElement: aPivotalElement.
	self radians: anAngleInRadians
]

{ #category : #configuration }
ToAnchoredAtPerimeter >> configure: anAnchored [

	anAnchored constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors centerAnchor on:
					 (pivotalElement perimeterAnchor radians: radians)
					 + anAnchored offset) ]
]

{ #category : #accessing }
ToAnchoredAtPerimeter >> degrees: anAngleInDegrees [

	radians := anAngleInDegrees degreesToRadians 
]

{ #category : #accessing }
ToAnchoredAtPerimeter >> pivotalElement: anElement [

	pivotalElement := anElement
]

{ #category : #accessing }
ToAnchoredAtPerimeter >> radians: anAngleInRadians [

	radians := anAngleInRadians
]
