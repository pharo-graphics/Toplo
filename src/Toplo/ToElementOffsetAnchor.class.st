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

{ #category : #applying }
ToElementOffsetAnchor >> read: aRectangle withMargin: anInsets [

	^ offset value: (baseAnchor read: aRectangle withMargin: anInsets)
]
