Class {
	#name : #ToDraggedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDraggedLookEvent >> sendTo: anObject [

	anObject draggedLookEvent: self
]
