Class {
	#name : #ToSelecterChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToSelecterChangedEvent >> sendTo: anObject [

	anObject selecterChangedEvent: self
]
