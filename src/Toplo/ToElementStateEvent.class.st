Class {
	#name : #ToElementStateEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToElementStateEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #accessing }
ToElementStateEvent >> sendTo: anObject [

	anObject elementStateEvent: self
]

{ #category : #accessing }
ToElementStateEvent >> sendToLook: aLook [

	self subclassResponsibility 
]
