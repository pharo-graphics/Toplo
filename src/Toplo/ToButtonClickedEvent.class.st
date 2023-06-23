Class {
	#name : #ToButtonClickedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToButtonClickedEvent >> sendTo: anObject [

	^ anObject buttonClickedEvent: self
]
