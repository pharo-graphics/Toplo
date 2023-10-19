Class {
	#name : #ToClickedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #testing }
ToClickedState >> isPersistent [

	^ false
]

{ #category : #accessing }
ToClickedState >> lookEventClass [

	^ ToClickedLookEvent 
]
