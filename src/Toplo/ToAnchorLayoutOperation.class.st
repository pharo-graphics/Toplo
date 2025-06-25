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

	| targetRectangle margin |
	targetAnchor element
		ifNil: [
				targetRectangle := availableRectangle.
				margin := BlInsets empty ]
		ifNotNil: [ :e |
				targetRectangle := e measuredBounds inParent asRectangle.
				margin := e margin ].
	^ baseAnchor
		  applyOnRectangle: childBoundsRectangle
		  withValue: (targetAnchor read: targetRectangle withMargin: margin)
		  withMargin: (baseAnchor element margin)
]

{ #category : #accessing }
ToAnchorLayoutOperation >> baseAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
ToAnchorLayoutOperation >> targetAnchor: anObject [

	targetAnchor := anObject
]
