Class {
	#name : #ToDividerEndDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #sending }
ToDividerEndDragEvent >> sendTo: anObject [

	anObject dividerEndDragEvent: self
]
