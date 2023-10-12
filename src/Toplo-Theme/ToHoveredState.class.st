Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToHoveredState >> lookEventClass [

	^ ToHoveredLookEvent
]
