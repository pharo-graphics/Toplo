Class {
	#name : #ToTreeClassWrapper,
	#superclass : #ToTreeWrapper,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #accessing }
ToTreeClassWrapper >> children [

	^ wrappedObject subclasses asOrderedCollection 
]
