Class {
	#name : #ToSelectedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToSelectedState >> lookEventClass [

	^ ToSelectedLookEvent
]
