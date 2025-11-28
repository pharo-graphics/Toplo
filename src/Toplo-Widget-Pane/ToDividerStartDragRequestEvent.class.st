Class {
	#name : #ToDividerStartDragRequestEvent,
	#superclass : #ToDividerRequestEvent,
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #sending }
ToDividerStartDragRequestEvent >> sendTo: anObject [

	anObject dividerDragStartRequestEvent: self
]
