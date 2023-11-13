Class {
	#name : 'ToFocusState',
	#superclass : 'ToIntrinsicState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToFocusState >> lookEventClass [

	^ self rawState
		  ifTrue: [ ToFocusedLookEvent ]
		  ifFalse: [ ToUnfocusedLookEvent ]
]
