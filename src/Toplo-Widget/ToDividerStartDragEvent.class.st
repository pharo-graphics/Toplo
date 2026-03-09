Class {
	#name : #ToDividerStartDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #sending }
ToDividerStartDragEvent >> sendTo: anObject [

	anObject dividerStartDragEvent: self
]
