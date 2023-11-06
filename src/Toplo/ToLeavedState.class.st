Class {
	#name : 'ToLeavedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToLeavedState >> incompatibleStateClasses [

	^ { ToHoveredState }
]

{ #category : 'testing' }
ToLeavedState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToLeavedState >> lookEventClass [

	^ ToLeavedLookEvent
]
