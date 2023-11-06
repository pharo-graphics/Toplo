Class {
	#name : 'ToFocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToFocusedState >> incompatibleStateClasses [

	^ { ToUnfocusedState } 
]

{ #category : 'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
