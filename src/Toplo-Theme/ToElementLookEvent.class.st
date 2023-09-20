Class {
	#name : #ToElementLookEvent,
	#superclass : #BlEvent,
	#instVars : [
		'currentUpdater'
	],
	#category : 'Toplo-Theme-Core'
}

{ #category : #accessing }
ToElementLookEvent >> currentUpdater [

	^ currentUpdater
]

{ #category : #accessing }
ToElementLookEvent >> currentUpdater: anObject [

	currentUpdater := anObject
]

{ #category : #accessing }
ToElementLookEvent >> currentUpdaterDo: aBlock [

	^ currentUpdater ifNotNil: [ :u | aBlock value: u ]
]

{ #category : #accessing }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #sending }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : #sending }
ToElementLookEvent >> sendToLook: aLook [

	aLook receiveEvent: self
]
