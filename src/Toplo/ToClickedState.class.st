Class {
	#name : 'ToClickedState',
	#superclass : 'ToTransitionState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToClickedState >> lookEventClass [

	^ ToClickedLookEvent 
]
