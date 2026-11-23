"
I am the event handler that turns the Bloc drag events received by a `ToDivider` into divider requests and events.

I remember where the drag started, both the position of the pointer and of the divider, and compute each delta from there. A move is therefore always relative to the start of the drag, so rounding does not accumulate.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- The divider moves inside the action of `ToDividerDragRequestEvent`: a denied request leaves it where it was.
- The delta keeps only the axis across the divider, the other coordinate is zero.

## Usage

1. `ToDivider>>defaultEventHandler` creates me and `ToDivider>>initialize` adds me to the divider. `ToPaneDivider` uses my subclass `ToPaneDividerEventHandler`.
2. The divider sends me the drag events. I dispatch the requests and events on it.

I keep the state of one drag, so I serve a single divider.
"
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
