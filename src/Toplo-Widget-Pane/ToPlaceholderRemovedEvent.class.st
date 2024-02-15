Class {
	#name : #ToPlaceholderRemovedEvent,
	#superclass : #ToPlaceholderEvent,
	#category : 'Toplo-Widget-Pane'
}

{ #category : #sending }
ToPlaceholderRemovedEvent >> sendTo: anObject [

	anObject placeHolderRemovedEvent: self
]
