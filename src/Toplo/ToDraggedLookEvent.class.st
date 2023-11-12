Class {
	#name : #ToDraggedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDraggedLookEvent >> sendTo: anObject [

	anObject draggedLookEvent: self
]
