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
