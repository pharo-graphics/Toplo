Class {
	#name : 'ToFocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToFocusedState >> incompatibleStateClasses [

	^ { ToUnfocusedState } 
]

{ #category : 'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
