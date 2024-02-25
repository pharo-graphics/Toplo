Class {
	#name : #ToPlaceholderHiddenEvent,
	#superclass : #ToPlaceholderEvent,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #sending }
ToPlaceholderHiddenEvent >> sendTo: anObject [

	anObject placeHolderHiddenEvent: self
]
