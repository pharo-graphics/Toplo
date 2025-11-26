Class {
	#name : #ToDividerDragRequestEvent,
	#superclass : #ToDividerRequestEvent,
	#instVars : [
		'delta'
	],
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #accessing }
ToDividerDragRequestEvent >> delta [

	^ delta
]

{ #category : #accessing }
ToDividerDragRequestEvent >> delta: aPoint [

	delta := aPoint
]

{ #category : #sending }
ToDividerDragRequestEvent >> sendTo: anObject [

	anObject dividerDragRequestEvent: self
]
