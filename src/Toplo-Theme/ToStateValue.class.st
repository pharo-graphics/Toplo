Class {
	#name : #ToStateValue,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #converting }
ToStateValue >> asStateValue [

	^ self
]

{ #category : #accessing }
ToStateValue >> value: anObject [

	value := anObject
]

{ #category : #accessing }
ToStateValue >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]
