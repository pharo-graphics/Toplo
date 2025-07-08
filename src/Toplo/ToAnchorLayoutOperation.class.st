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
ToAnchorLayoutOperation >> appliedOnChildBounds: childBoundsRectangle withParent: anElement [

	^ anElement globalBoundsToLocal: (leftHandSideAnchor
		  appliedOnRectangle: childBoundsRectangle
		  withValue: (rightHandSideAnchor valueInParent: anElement))
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
