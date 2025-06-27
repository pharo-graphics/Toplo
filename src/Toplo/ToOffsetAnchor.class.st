Class {
	#name : #ToOffsetAnchor,
	#superclass : #ToAnchor,
	#instVars : [
		'baseAnchor',
		'offset'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToOffsetAnchor >> element [

	^ baseAnchor element
]

{ #category : #accessing }
ToOffsetAnchor >> leftHandSideAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
ToOffsetAnchor >> offset: aValuable [

	offset := aValuable
]

{ #category : #applying }
ToOffsetAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ offset value: (baseAnchor
			   valueForChild: aChildElement
			   withBoundsRectangle: aRectangle)
]
