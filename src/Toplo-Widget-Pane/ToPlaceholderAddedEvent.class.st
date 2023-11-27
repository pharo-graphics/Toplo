Class {
	#name : 'ToPlaceholderAddedEvent',
	#superclass : 'ToPlaceholderEvent',
	#category : 'Toplo-Widget-Pane',
	#package : 'Toplo-Widget-Pane'
}

{ #category : 'sending' }
ToPlaceholderAddedEvent >> sendTo: anObject [

	anObject placeHolderAddedEvent: self
]
