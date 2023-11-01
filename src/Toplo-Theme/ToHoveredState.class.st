Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToHoveredState >> incompatibleStateClasses [

	^ { ToLeavedState } 
]

{ #category : #'look event sending' }
ToHoveredState >> lookEventClass [

	^ ToHoveredLookEvent
]
