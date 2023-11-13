Class {
	#name : 'ToReleasedState',
	#superclass : 'ToTransitionState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToReleasedState >> lookEventClass [

	^ ToReleasedLookEvent
]
