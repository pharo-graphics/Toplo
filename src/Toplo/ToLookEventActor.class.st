Class {
	#name : 'ToLookEventActor',
	#superclass : 'Object',
	#instVars : [
		'eventClass'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'look event handling' }
ToLookEventActor >> applyOn: anObject [

	self subclassResponsibility 
]

{ #category : 'testing' }
ToLookEventActor >> canReceiveEvent: aLookEvent [ 

	^ self eventClass = aLookEvent class 
]

{ #category : 'accessing' }
ToLookEventActor >> eventClass [

	^ eventClass ifNil: [ eventClass := ToInstallLookEvent  ]
]

{ #category : 'accessing' }
ToLookEventActor >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : 'look event handling' }
ToLookEventActor >> receiveEvent: aLookEvent [

	| target |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	self applyOn: target
]
