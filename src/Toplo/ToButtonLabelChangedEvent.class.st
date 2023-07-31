Class {
	#name : #ToButtonLabelChangedEvent,
	#superclass : #ToElementPropertyChangedEvent,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToButtonLabelChangedEvent >> sendTo: anObject [

	anObject buttonLabelChanged: self
]
