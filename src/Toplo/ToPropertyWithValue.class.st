Class {
	#name : #ToPropertyWithValue,
	#superclass : #ToAbstractProperty,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #accessing }
ToPropertyWithValue class >> name: aSymbol [

	^ self new name: aSymbol asSymbol
]

{ #category : #accessing }
ToPropertyWithValue class >> name: aSymbol value: anObject [

	^ (self name: aSymbol)
		  value: anObject;
		  yourself
]

{ #category : #comparing }
ToPropertyWithValue >> = anObject [ 

	anObject == self ifTrue: [ ^ true ].
	anObject class == self class ifFalse: [ ^ false ].
	^ self name = anObject name and: [ self value = anObject value ]
]

{ #category : #accessing }
ToPropertyWithValue >> value [

	^ value
]

{ #category : #accessing }
ToPropertyWithValue >> value: anObject [

	value := anObject
]
