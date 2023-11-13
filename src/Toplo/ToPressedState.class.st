Class {
	#name : 'ToPressedState',
	#superclass : 'ToTransitionState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToPressedState >> lookEventClass [

	^ ToPressedLookEvent
]
