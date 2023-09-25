Class {
	#name : #ToStyleNamedValue,
	#superclass : #ToElementProperty,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #operating }
ToStyleNamedValue >> read: anObject [

	^ self value value: anObject
]

{ #category : #accessing }
ToStyleNamedValue >> value [

	^ value
]

{ #category : #accessing }
ToStyleNamedValue >> value: aValuable [

	value := aValuable
]
