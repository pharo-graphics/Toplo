Class {
	#name : 'ToOpenedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToOpenedState >> incompatibleStateClasses [

	^ { ToClosedState } 
]

{ #category : 'sending' }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
