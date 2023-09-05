Class {
	#name : #ToSkinnablePropertyChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #sending }
ToSkinnablePropertyChangedEvent >> sendTo: anObject [

	anObject skinnablePropertyChangedEvent: self
]
