Class {
	#name : #ToUnfocusedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToUnfocusedState >> incompatibleStateClasses [

	^ { ToFocusedState }.

]

{ #category : #accessing }
ToUnfocusedState >> lookEventClass [

	^ ToUnfocusedLookEvent 
]
