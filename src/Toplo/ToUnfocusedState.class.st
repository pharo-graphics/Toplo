Class {
	#name : #ToUnfocusedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToUnfocusedState >> incompatibleStateClasses [

	^ { ToFocusedState }.

]

{ #category : #accessing }
ToUnfocusedState >> lookEventClass [

	^ ToUnfocusedLookEvent 
]
