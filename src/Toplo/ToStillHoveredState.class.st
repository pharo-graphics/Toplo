Class {
	#name : 'ToStillHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
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
