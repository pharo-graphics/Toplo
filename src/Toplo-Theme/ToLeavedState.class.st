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

{ #category : 'testing' }
ToLeavedState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToLeavedState >> lookEventClass [

	^ ToLeavedLookEvent
]
