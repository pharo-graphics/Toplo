Class {
	#name : #ToTabModel,
	#superclass : #Object,
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'data',
		'closable'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #accessing }
ToTabModel >> closable: aBoolean [

	closable := aBoolean
]

{ #category : #accessing }
ToTabModel >> data [

	^ data
]

{ #category : #accessing }
ToTabModel >> data: anObject [

	data := anObject
]

{ #category : #initialization }
ToTabModel >> initialize [

	super initialize.
	closable := false
]

{ #category : #testing }
ToTabModel >> isClosable [

	^ closable
]
