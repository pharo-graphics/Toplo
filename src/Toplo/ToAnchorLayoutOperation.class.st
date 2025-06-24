Class {
	#name : #ToAnchorLayoutOperation,
	#superclass : #Object,
	#instVars : [
		'targetAnchor',
		'baseAnchor'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #layout }
ToAnchorLayoutOperation >> applyOnChildBounds: childBoundsRectangle in: availableRectangle [

	| targetRectangle |
	targetRectangle := targetAnchor element
		                   ifNil: [ availableRectangle ]
		                   ifNotNil: [ :e | e measuredBounds inParent asRectangle ].
	^ baseAnchor
		  translate: childBoundsRectangle
		  to: (targetAnchor read: targetRectangle)
]

{ #category : #accessing }
ToAnchorLayoutOperation >> baseAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
ToAnchorLayoutOperation >> targetAnchor: anObject [

	targetAnchor := anObject
]
