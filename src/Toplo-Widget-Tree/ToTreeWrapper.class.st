Class {
	#name : #ToTreeWrapper,
	#superclass : #Object,
	#instVars : [
		'wrappedObject'
	],
	#category : #'Toplo-Widget-Tree'
}

{ #category : #accessing }
ToTreeWrapper >> children [ 

	self subclassResponsibility 
]

{ #category : #accessing }
ToTreeWrapper >> wrappedObject [ 

	^ wrappedObject 
]

{ #category : #accessing }
ToTreeWrapper >> wrappedObject: anObject [

	wrappedObject := anObject 
]
