Class {
	#name : 'ToOpenState',
	#superclass : 'ToIntrinsicState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'sending' }
ToOpenState >> lookEventClass [

	^ self rawState
		  ifTrue: [ ToOpenedLookEvent ]
		  ifFalse: [ ToClosedLookEvent ]
]
