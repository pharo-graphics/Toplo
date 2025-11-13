Class {
	#name : #ToDividerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dividerStartPosition',
		'globalStartPosition'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #accessing }
ToDividerEventHandler >> dragDeltaFromEvent: anEvent [

	^ (anEvent position - globalStartPosition) rounded
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| dragDelta divider |
	anEvent consume.

	divider := anEvent currentTarget.
	dragDelta := self dragDeltaFromEvent: anEvent.

	divider isHorizontal
		ifTrue: [
		divider position: dividerStartPosition + (0.0 @ dragDelta y) ]
		ifFalse: [
		divider position: dividerStartPosition + (dragDelta x @ 0.0) ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragStartEvent: anEvent [
	" consume before super send to ensure dragged state "

	| divider |
	anEvent consume.
	divider := anEvent currentTarget.

	"drag start position in parent"
	globalStartPosition := anEvent position.
	dividerStartPosition :=  divider constraints position 
]

{ #category : #'api - accessing' }
ToDividerEventHandler >> eventsToHandle [

	^ {
		  BlDragEvent.
		  BlDragStartEvent }
]

{ #category : #accessing }
ToDividerEventHandler >> minimumExtent [

	^ 1@1
]
