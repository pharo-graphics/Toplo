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
ToDividerEventHandler >> dragEndEvent: anEvent [
	" consume before super send to ensure dragged state "

	| divider |
	divider := anEvent currentTarget.

	divider dispatchEvent: (ToDividerEndDragEvent new
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragEvent: anEvent [

	| dragDelta divider orientedDragDelta req |
	divider := anEvent currentTarget.
	dragDelta := self dragDeltaFromEvent: anEvent.
	orientedDragDelta := divider isHorizontal
		                     ifTrue: [ 0.0 @ dragDelta y ]
		                     ifFalse: [ dragDelta x @ 0.0 ].

	req := ToDividerDragRequestEvent new
		       sourceEvent: anEvent;
		       delta: orientedDragDelta;
		       requestedAction: [
				       anEvent consume.
				       divider position: dividerStartPosition + orientedDragDelta.
				       divider dispatchEvent: (ToDividerDragEvent new
							        delta: orientedDragDelta;
							        sourceEvent: anEvent;
							        yourself) ];
		       yourself.

	divider dispatchRequest: req
]

{ #category : #'dnd handlers' }
ToDividerEventHandler >> dragStartEvent: anEvent [
	" consume before super send to ensure dragged state "

	| divider req |
	divider := anEvent currentTarget.

	"drag start position in parent"
	globalStartPosition := anEvent position.
	dividerStartPosition := divider constraints position.

	req := ToDividerStartDragRequestEvent new
		       sourceEvent: anEvent;
		       requestedAction: [
				       anEvent consume.
				       divider dispatchEvent: (ToDividerStartDragEvent new
							        sourceEvent: anEvent;
							        yourself) ];
		       yourself.

	divider dispatchRequest: req
]

{ #category : #'api - accessing' }
ToDividerEventHandler >> eventsToHandle [

	^ {
		  BlDragEvent.
		  BlDragStartEvent.
		  BlDragEndEvent }
]

{ #category : #accessing }
ToDividerEventHandler >> minimumExtent [

	^ 1@1
]
