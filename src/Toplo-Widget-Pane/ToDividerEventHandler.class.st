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

	| divider localStartPosition localEventPosition |
	divider := anEvent currentTarget.
	localStartPosition := divider globalPointToLocal: globalStartPosition.
	localEventPosition := divider globalPointToLocal: anEvent position.
	^ (localEventPosition - localStartPosition) rounded
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| dragDelta divider orientedDragDelta |
	anEvent consume.

	divider := anEvent currentTarget.
	dragDelta := self dragDeltaFromEvent: anEvent.
	orientedDragDelta := divider isHorizontal
		                     ifTrue: [ 0.0 @ dragDelta y ]
		                     ifFalse: [ dragDelta x @ 0.0 ].

	divider position: dividerStartPosition + orientedDragDelta.
	divider dispatchEvent:
		(ToDividerDraggedEvent new delta: orientedDragDelta)
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
