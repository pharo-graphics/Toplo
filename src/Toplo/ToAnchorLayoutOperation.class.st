Class {
	#name : #ToAnchorLayoutOperation,
	#superclass : #Object,
	#instVars : [
		'leftHandSideAnchor',
		'rightHandSideAnchor'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #layout }
ToAnchorLayoutOperation >> appliedForChild: aChildElement withBounds: childBoundsRectangle withParent: anElement inAvailableRectangle: availableRectangle [

	| targetRectangle |
	targetRectangle := rightHandSideAnchor element = anElement
		                   ifTrue: [ availableRectangle ]
		                   ifFalse: [
				                   (rightHandSideAnchor element measuredBounds
					                    inParent: anElement) asRectangle ].
	^ leftHandSideAnchor
		  appliedOnRectangle: childBoundsRectangle
		  withValue: (rightHandSideAnchor readRectangle: targetRectangle)
]

{ #category : #testing }
ToAnchorLayoutOperation >> isMeasurement [ 

	^ leftHandSideAnchor isMeasurement 
]

{ #category : #accessing }
ToAnchorLayoutOperation >> leftHandSideAnchor: anAnchor [

	leftHandSideAnchor := anAnchor
]

{ #category : #accessing }
ToAnchorLayoutOperation >> rightHandSideAnchor: anAnchor [

	rightHandSideAnchor := anAnchor
]
