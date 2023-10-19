Class {
	#name : #ToFocusedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToFocusedState >> incompatibleStateClasses [

	^ { ToUnfocusedState } 
]

{ #category : #'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
