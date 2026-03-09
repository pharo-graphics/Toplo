Class {
	#name : #ToDividerDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#instVars : [
		'delta'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToDividerDragEvent >> delta [

	^ delta
]

{ #category : #accessing }
ToDividerDragEvent >> delta: aPoint [

	delta := aPoint
]

{ #category : #sending }
ToDividerDragEvent >> sendTo: anObject [

	anObject dividerDragEvent: self
]
