Class {
	#name : #ToElementOffsetAnchor,
	#superclass : #ToAnchor,
	#instVars : [
		'baseAnchor',
		'offset'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementOffsetAnchor >> element [

	^ baseAnchor element
]

{ #category : #accessing }
ToElementOffsetAnchor >> leftHandSideAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
ToElementOffsetAnchor >> offset: aValuable [

	offset := aValuable
]

{ #category : #applying }
ToElementOffsetAnchor >> readRectangle: aRectangle [ 

	^ offset value: (baseAnchor readRectangle: aRectangle )
]
