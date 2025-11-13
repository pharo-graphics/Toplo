Class {
	#name : #ToDividerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'startPosition'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| dragDelta divider |
	anEvent consume.

	divider := anEvent currentTarget.
	dragDelta := anEvent position - startPosition.
	(divider isVertical and: [ divider parent isLeftToRight ]) ifTrue: [
		dragDelta := dragDelta negated ].

	divider isHorizontal
		ifTrue: [ divider position: startPosition + (0.0 @ dragDelta y) ]
		ifFalse: [
			divider position:
				startPosition position + (dragDelta x negated @ 0.0) ]
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragStartEvent: anEvent [
	" consume before super send to ensure dragged state "

	| divider |
	anEvent consume.
	divider := anEvent currentTarget.

	"drag start position in parent"
	startPosition := anEvent position
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
