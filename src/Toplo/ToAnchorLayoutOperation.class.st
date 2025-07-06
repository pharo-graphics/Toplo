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
ToAnchorLayoutOperation >> appliedOnChildBounds: childBoundsRectangle withParent: anElement inAvailableRectangle: availableRectangle [

	| targetRectangle |
	targetRectangle := anElement padding inset: (rightHandSideAnchor element measuredBounds
		                    inParent: anElement).
	
	^ leftHandSideAnchor
		  appliedOnRectangle: childBoundsRectangle
		  withValue: (rightHandSideAnchor readRectangle: targetRectangle)
]

{ #category : #accessing }
ToAnchorLayoutOperation >> baseAnchor: anAnchor [

	leftHandSideAnchor := anAnchor
]

{ #category : #testing }
ToAnchorLayoutOperation >> isMeasurement [ 

	^ leftHandSideAnchor isMeasurement 
]

{ #category : #accessing }
ToAnchorLayoutOperation >> rightHandSideAnchor: anAnchor [

	rightHandSideAnchor := anAnchor
]
