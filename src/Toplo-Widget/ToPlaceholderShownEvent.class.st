Class {
	#name : #ToPlaceholderShownEvent,
	#superclass : #ToPlaceholderEvent,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #sending }
ToPlaceholderShownEvent >> sendTo: anObject [

	anObject placeHolderShownEvent: self
]
