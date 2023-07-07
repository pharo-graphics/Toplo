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

	backgoundUpdater := aBoolean
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

{ #category : #testing }
ToElementLookEvent >> ifNotBackgoundUpdated: aBlock [

	self backgoundUpdater ifTrue: [ ^ self ].
	aBlock value
]

{ #category : #sending }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : #sending }
ToElementLookEvent >> sendToLook: aLook [

	self subclassResponsibility 
]
