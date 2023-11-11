Class {
	#name : #ToFocusedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToFocusedState >> incompatibleStateClasses [

	^ { ToUnfocusedState } 
]

{ #category : #'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
