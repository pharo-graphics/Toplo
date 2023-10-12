Class {
	#name : #ToDisabledState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToDisabledState >> lookEventClass [

	^ ToDisabledLookEvent
]
