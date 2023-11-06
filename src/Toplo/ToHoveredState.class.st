Class {
	#name : 'ToHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToHoveredState >> incompatibleStateClasses [

	^ { ToLeavedState } 
]

{ #category : 'look event sending' }
ToHoveredState >> lookEventClass [

	^ ToHoveredLookEvent
]
