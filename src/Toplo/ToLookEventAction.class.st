Class {
	#name : #ToLookEventAction,
	#superclass : #ToLookEventListener,
	#instVars : [
		'action'
	],
	#category : 'Toplo-Core-StyleSheet'
}

{ #category : #accessing }
ToLookEventAction >> action [

	^ action
]

{ #category : #accessing }
ToLookEventAction >> action: aValuable [

	" aValuable takes an element as unique argument "
	action := aValuable
]

{ #category : #'look event handling' }
ToLookEventAction >> applyOn: anObject [

	self action value: anObject
]

{ #category : #testing }
ToLookEventAction >> isSupplement [ 

	^ false
]

{ #category : #accessing }
ToLookEventAction >> property [

	^ ToNullProperty uniqueInstance 
]
