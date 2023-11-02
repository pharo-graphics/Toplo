Class {
	#name : #ToLayoutDirectionChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core'
}

{ #category : #sending }
ToLayoutDirectionChangedEvent >> sendTo: anObject [

	anObject layoutDirectionChangedEvent: self
]
