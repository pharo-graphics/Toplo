Class {
	#name : #ToButtonIconChangedEvent,
	#superclass : #ToElementPropertyChangedEvent,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToButtonIconChangedEvent >> sendTo: anObject [

	anObject buttonIconChanged: self
]
