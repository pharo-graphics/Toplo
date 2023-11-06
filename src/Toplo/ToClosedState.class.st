Class {
	#name : 'ToClosedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToClosedState >> incompatibleStateClasses [

	^ { ToOpenedState }
]

{ #category : 'sending' }
ToClosedState >> lookEventClass [

	^ ToClosedLookEvent
]
