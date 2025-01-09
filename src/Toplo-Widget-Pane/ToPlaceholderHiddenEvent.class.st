Class {
	#name : #ToPlaceholderHiddenEvent,
	#superclass : #ToPlaceholderEvent,
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #sending }
ToPlaceholderHiddenEvent >> sendTo: anObject [

	anObject placeHolderHiddenEvent: self
]
