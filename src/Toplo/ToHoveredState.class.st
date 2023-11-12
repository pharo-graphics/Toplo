Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToHoveredState >> incompatibleStateClasses [

	^ { ToLeavedState } 
]

{ #category : #'look event sending' }
ToHoveredState >> lookEventClass [

	^ ToHoveredLookEvent
]
