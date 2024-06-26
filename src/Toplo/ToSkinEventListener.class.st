Class {
	#name : #ToSkinEventListener,
	#superclass : #Object,
	#instVars : [
		'eventClass'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'look event handling' }
ToSkinEventListener >> applyOn: anObject [

	self subclassResponsibility 
]

{ #category : #testing }
ToSkinEventListener >> canReceiveEvent: aSkinEvent [ 

	^ self eventClass = aSkinEvent class 
]

{ #category : #accessing }
ToSkinEventListener >> eventClass [

	^ eventClass ifNil: [ eventClass := ToInstallSkinEvent  ]
]

{ #category : #accessing }
ToSkinEventListener >> eventClass: aSkinEventClass [

	eventClass := aSkinEventClass
]

{ #category : #testing }
ToSkinEventListener >> isAction [

	^ false
]

{ #category : #testing }
ToSkinEventListener >> isPropertyWriter [

	^ false
]

{ #category : #testing }
ToSkinEventListener >> isSupplement [ 

	^ self subclassResponsibility 
]

{ #category : #'look event handling' }
ToSkinEventListener >> receiveEvent: aSkinEvent [

	| target |
	(self canReceiveEvent: aSkinEvent) ifFalse: [ ^ self ].
	target := aSkinEvent currentTarget.
	self applyOn: target
]
