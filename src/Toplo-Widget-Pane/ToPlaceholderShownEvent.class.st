Class {
	#name : #ToPlaceholderShownEvent,
	#superclass : #ToPlaceholderEvent,
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #sending }
ToPlaceholderShownEvent >> sendTo: anObject [

	anObject placeHolderShownEvent: self
]
