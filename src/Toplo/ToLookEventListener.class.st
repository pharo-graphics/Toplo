Class {
	#name : #ToLookEventListener,
	#superclass : #Object,
	#instVars : [
		'eventClass'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'look event handling' }
ToLookEventListener >> applyOn: anObject [

	self subclassResponsibility 
]

{ #category : #testing }
ToLookEventListener >> canReceiveEvent: aLookEvent [ 

	^ self eventClass = aLookEvent class 
]

{ #category : #accessing }
ToLookEventListener >> eventClass [

	^ eventClass ifNil: [ eventClass := ToInstallLookEvent  ]
]

{ #category : #accessing }
ToLookEventListener >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #testing }
ToLookEventListener >> isSupplement [ 

	^ self subclassResponsibility 
]

{ #category : #'look event handling' }
ToLookEventListener >> receiveEvent: aLookEvent [

	| target |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	self applyOn: target
]
