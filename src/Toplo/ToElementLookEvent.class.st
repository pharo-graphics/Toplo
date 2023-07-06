Class {
	#name : #ToElementLookEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #accessing }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : #accessing }
ToElementLookEvent >> sendToLook: aLook [

	self subclassResponsibility 
]
