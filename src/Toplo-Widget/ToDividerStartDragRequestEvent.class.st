Class {
	#name : #ToDividerStartDragRequestEvent,
	#superclass : #ToDividerRequestEvent,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #sending }
ToDividerStartDragRequestEvent >> sendTo: anObject [

	anObject dividerDragStartRequestEvent: self
]
