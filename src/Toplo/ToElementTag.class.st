Class {
	#name : #ToElementTag,
	#superclass : #ToElementProperty,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #operating }
ToElementTag >> read: anObject [

	^ self value value: anObject
]

{ #category : #accessing }
ToElementTag >> value [

	^ value
]

{ #category : #accessing }
ToElementTag >> value: aValuable [

	value := aValuable
]
