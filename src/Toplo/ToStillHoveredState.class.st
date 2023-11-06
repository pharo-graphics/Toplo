Class {
	#name : 'ToStillHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
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
