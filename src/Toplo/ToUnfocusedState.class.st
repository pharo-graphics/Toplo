Class {
	#name : 'ToUnfocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToUnfocusedState >> incompatibleStateClasses [

	^ { ToFocusedState }.

]

{ #category : 'accessing' }
ToUnfocusedState >> lookEventClass [

	^ ToUnfocusedLookEvent 
]
