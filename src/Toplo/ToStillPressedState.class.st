Class {
	#name : 'ToStillPressedState',
	#superclass : 'ToTransitionState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToStillPressedState >> lookEventClass [

	^ ToStillPressedLookEvent
]
