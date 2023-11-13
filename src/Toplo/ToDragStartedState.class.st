Class {
	#name : 'ToDragStartedState',
	#superclass : 'ToTransitionState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToDragStartedState >> lookEventClass [

	^ ToDragStartedLookEvent
]
