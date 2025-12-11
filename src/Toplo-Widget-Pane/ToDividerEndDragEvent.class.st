Class {
	#name : #ToDividerEndDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #sending }
ToDividerEndDragEvent >> sendTo: anObject [

	anObject dividerEndDragEvent: self
]
