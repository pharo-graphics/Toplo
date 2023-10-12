Class {
	#name : #ToPressedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #testing }
ToPressedState >> isPressedState [

	^ true
]

{ #category : #'look event sending' }
ToPressedState >> lookEventClass [

	^ ToPressedLookEvent
]
