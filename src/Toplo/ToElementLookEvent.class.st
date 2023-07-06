Class {
	#name : #ToElementLookEvent,
	#superclass : #BlEvent,
	#instVars : [
		'backgoundUpdater'
	],
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToElementLookEvent >> backgoundUpdater [

	^ backgoundUpdater ifNil: [ backgoundUpdater := true ]
]

{ #category : #accessing }
ToElementLookEvent >> backgoundUpdater: aBoolean [

	backgoundUpdater := self backgoundUpdater and: [ aBoolean ]
]

{ #category : #accessing }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #testing }
ToElementLookEvent >> ifBackgoundUpdated: aBlock [

	self backgoundUpdater ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #accessing }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : #accessing }
ToElementLookEvent >> sendToLook: aLook [

	self subclassResponsibility 
]
