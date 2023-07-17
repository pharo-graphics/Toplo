Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToElementState >> sendEvent: anEvent toLook: aLook [

	self subclassResponsibility 
]
