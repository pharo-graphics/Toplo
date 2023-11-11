Class {
	#name : #ToLeavedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToLeavedState >> incompatibleStateClasses [

	^ { ToHoveredState }
]

{ #category : #testing }
ToLeavedState >> isPersistent [ 

	^ false
]

{ #category : #accessing }
ToLeavedState >> lookEventClass [

	^ ToLeavedLookEvent
]
