Class {
	#name : #ToSkinnablePropertyChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #sending }
ToSkinnablePropertyChangedEvent >> sendTo: anObject [

	anObject skinnablePropertyChangedEvent: self
]
