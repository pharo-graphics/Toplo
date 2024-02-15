Class {
	#name : #ToLayoutConstraintsChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core'
}

{ #category : #sending }
ToLayoutConstraintsChangedEvent >> sendTo: anObject [

	anObject layoutConstraintsChangedEvent: self
]
