Class {
	#name : #ToSkinnablePropertyChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#category : #'Toplo-Core-Slots'
}

{ #category : #sending }
ToSkinnablePropertyChangedEvent >> sendTo: anObject [

	anObject skinnablePropertyChangedEvent: self
]
