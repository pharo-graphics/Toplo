Class {
	#name : #ToElementLookEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Theme'
}

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

	self subclassResponsibility 
]
