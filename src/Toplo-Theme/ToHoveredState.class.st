Class {
	#name : 'ToHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToHoveredState >> incompatibleStateClasses [

	^ { ToLeavedState } 
]

{ #category : 'look event sending' }
ToHoveredState >> lookEventClass [

	^ ToHoveredLookEvent
]
