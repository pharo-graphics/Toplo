Class {
	#name : #ToElementOffsetAnchor,
	#superclass : #ToElementAnchor,
	#instVars : [
		'baseAnchor',
		'offset'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementOffsetAnchor >> baseAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
ToElementOffsetAnchor >> element [

	^ baseAnchor element
]

{ #category : #accessing }
ToElementOffsetAnchor >> offset: aValuable [

	offset := aValuable
]

{ #category : #evaluating }
ToElementOffsetAnchor >> read: aRectangle [


	^ offset value: (baseAnchor read: aRectangle)
]
