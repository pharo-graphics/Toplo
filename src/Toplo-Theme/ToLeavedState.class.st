Class {
	#name : 'ToLeavedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToLeavedState >> incompatibleStateClasses [

	^ { ToHoveredState }
]

{ #category : 'look event sending' }
ToLeavedState >> lookEventClass [

	^ ToLeavedLookEvent
]
