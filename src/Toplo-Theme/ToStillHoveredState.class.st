Class {
	#name : 'ToStillHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToStillHoveredState >> incompatibleStateClasses [

	^ { ToHoveredState }   
]

{ #category : 'testing' }
ToStillHoveredState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToStillHoveredState >> lookEventClass [

	^ ToStillHoveredLookEvent
]
