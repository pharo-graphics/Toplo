Class {
	#name : 'ToFocusState',
	#superclass : 'ToIntrinsicState',
	#instVars : [
		'focused'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToFocusState >> focused [

	^ focused
]

{ #category : 'accessing' }
ToFocusState >> focused: aBoolean [

	focused := aBoolean
]

{ #category : 'look event sending' }
ToFocusState >> lookEventClass [

	^ self rawState
		  ifTrue: [ ToFocusedLookEvent ]
		  ifFalse: [ ToUnfocusedLookEvent ]
]
