Class {
	#name : #ToPropertyValue,
	#superclass : #Object,
	#instVars : [
		'property',
		'value'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #accessing }
ToPropertyValue >> property [

	^ property
]

{ #category : #accessing }
ToPropertyValue >> property: anObject [

	property := anObject
]

{ #category : #accessing }
ToPropertyValue >> value [

	^ value
]

{ #category : #accessing }
ToPropertyValue >> value: anObject [

	value := anObject
]
