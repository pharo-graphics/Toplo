Class {
	#name : #ToDividerStartDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #sending }
ToDividerStartDragEvent >> sendTo: anObject [

	anObject dividerStartDragEvent: self
]
