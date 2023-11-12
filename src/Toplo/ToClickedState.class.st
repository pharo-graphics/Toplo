Class {
	#name : #ToClickedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #testing }
ToClickedState >> isPersistent [

	^ false
]

{ #category : #accessing }
ToClickedState >> lookEventClass [

	^ ToClickedLookEvent 
]
