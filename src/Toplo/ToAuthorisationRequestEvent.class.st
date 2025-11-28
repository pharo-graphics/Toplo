Class {
	#name : #ToAuthorisationRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'requestedAction',
		'authorized'
	],
	#category : #'Toplo-Core'
}

{ #category : #visiting }
ToAuthorisationRequestEvent >> accept [

	self
		deprecated: 'Use authorize: instead'
		transformWith: '`@receiver accept' -> '`@receiver authorized: true'.
	self authorized: true
]

{ #category : #visiting }
ToAuthorisationRequestEvent >> accept: aBoolean [

	self
		deprecated: 'Use authorized: instead'
		transformWith:
		'`@receiver accept: `@argument'
		-> '`@receiver authorized: `@argument'.

	self authorized: aBoolean
]

{ #category : #visiting }
ToAuthorisationRequestEvent >> accepted [

	self
		deprecated: 'Use authorized instead'
		transformWith: '`@receiver accepted' -> '`@receiver authorized'.

	^ self authorized 
]

{ #category : #visiting }
ToAuthorisationRequestEvent >> authorized [

	^ authorized ifNil: [ true ]
]

{ #category : #visiting }
ToAuthorisationRequestEvent >> authorized: aBoolean [

	aBoolean ifTrue: [ ^ self ].
	authorized := aBoolean

	
]

{ #category : #visiting }
ToAuthorisationRequestEvent >> denied [

	^ self authorized not
]

{ #category : #visiting }
ToAuthorisationRequestEvent >> deny [

	self authorized: false.
	self consume
]

{ #category : #accessing }
ToAuthorisationRequestEvent >> requestedAction [

	^ requestedAction
]

{ #category : #accessing }
ToAuthorisationRequestEvent >> requestedAction: aBlock [

	requestedAction := aBlock
]
