Class {
	#name : #ToDividerDraggedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'delta'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #accessing }
ToDividerDraggedEvent >> delta [

	^ delta
]

{ #category : #accessing }
ToDividerDraggedEvent >> delta: aPoint [

	delta := aPoint
]

{ #category : #sending }
ToDividerDraggedEvent >> sendTo: anObject [

	anObject dividerDraggedEvent: self
]
