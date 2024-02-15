Class {
	#name : #ToLayoutOrientationChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core'
}

{ #category : #sending }
ToLayoutOrientationChangedEvent >> sendTo: anObject [

	anObject layoutOrientationChangedEvent: self
]
