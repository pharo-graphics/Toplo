"
I am the event handler of a `ToPaneDivider`: I add to the drag the resizing of the two elements it separates. See `ToDividerEventHandler` for the drag requests and events.

When the drag starts I remember the bounds of both elements, and each step resizes them from there. I also keep the divider in step with its pane: orientation, extent, and position of its elements.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- I listen to the pane and to the elements only while the divider is in the pane: the listeners are added when it is added to its parent and removed with it.
- Minimum extents stop an element from collapsing when the pointer goes past it.

## Usage

1. `ToPaneDivider>>defaultEventHandler` creates me and the divider adds me in `initialize`.
2. The divider sends me the drag events and the events of being added to and removed from its parent.

## Implementation Notes

- The elements are resized even when the drag request is denied: only the divider events are not dispatched. This is a known issue.
- In a left-to-right pane the delta is negated because `resizeBounds:by:onEvent:` subtracts the horizontal delta.
"
Class {
	#name : #ToPaneDividerEventHandler,
	#superclass : #ToDividerEventHandler,
	#instVars : [
		'additionalHandlers',
		'globalSideStartBounds'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'dnd handlers' }
ToPaneDividerEventHandler >> dragEvent: anEvent [

	| firstTargetBounds secondTargetBounds dragDelta divider secondDragDelta |
	anEvent consume.
	super dragEvent: anEvent.
	divider := anEvent currentTarget.
	firstTargetBounds := globalSideStartBounds first copy.
	secondTargetBounds := globalSideStartBounds second copy.

	dragDelta := self dragDeltaFromEvent: anEvent.

	(divider isVertical and: [ divider parent isLeftToRight ]) ifTrue: [
		dragDelta := dragDelta negated ].

	self
		dragEvent: anEvent
		resizedElement: divider firstResizedElement
		bounds: firstTargetBounds
		by: dragDelta.

	secondDragDelta := anEvent modifiers isShift
		                   ifTrue: [ 0 @ 0 ]
		                   ifFalse: [ dragDelta negated ].
	self
		dragEvent: anEvent
		resizedElement: divider secondResizedElement
		bounds: secondTargetBounds
		by: secondDragDelta.

	divider requestLayout
]

{ #category : #'dnd handlers' }
ToPaneDividerEventHandler >> dragEvent: anEvent resizedElement: aResizedElement bounds: aTargetBounds by: aDelta [

	| divider  |
	divider := anEvent currentTarget.

	" compute the new extent "
	self resizeBounds: aTargetBounds by: aDelta onEvent: anEvent.
	aResizedElement globalBoundsToLocal: aTargetBounds.
	aResizedElement localBoundsToParent: aTargetBounds.

	" in case of matchParent, the width/height must be converted as a weight "
	divider isVertical
		ifTrue: [
				self
					horizontalDragEvent: anEvent
					resizedElement: aResizedElement
					width: aTargetBounds width ]
		ifFalse: [
				self
					verticalDragEvent: anEvent
					resizedElement: aResizedElement
					height: aTargetBounds height ]
]

{ #category : #'dnd handlers' }
ToPaneDividerEventHandler >> dragStartEvent: anEvent [
	" consume before super send to ensure dragged state "

	| divider |
	super dragStartEvent: anEvent.
	divider := anEvent currentTarget.

	"side element's original bounds"
	globalSideStartBounds := {
		                         divider firstResizedElement bounds.
		                         divider secondResizedElement bounds }
		                         collect: [ :bnds | bnds inSpace bounds ]
]

{ #category : #'event handling' }
ToPaneDividerEventHandler >> elementAddedToParentEvent: anEvent [

	| divider pane |
	divider := anEvent currentTarget.
	pane := divider parent.
	
	divider horizontal: pane isVertical.
	additionalHandlers := OrderedCollection new.
	additionalHandlers add: pane -> (BlEventHandler
			 on: BlElementExtentChangedEvent
			 do: [ divider requestLayout ]).
	additionalHandlers add: pane -> (BlEventHandler
			 on: ToLayoutOrientationChangedEvent
			 do: [ divider horizontal: pane isVertical ]).
	additionalHandlers add:
		divider firstResizedElement -> (BlEventHandler
			 on: BlElementPositionChangedEvent
			 do: [ divider requestLayout ]).
	additionalHandlers add:
		divider secondResizedElement -> (BlEventHandler
			 on: BlElementPositionChangedEvent
			 do: [ divider requestLayout ]).

	additionalHandlers do: [ :assoc |
		assoc key addEventHandler: assoc value ]
]

{ #category : #'event handling' }
ToPaneDividerEventHandler >> elementRemovedFromParentEvent: anEvent [

	additionalHandlers do: [ :assoc | assoc key removeEventHandler: assoc value ].
	additionalHandlers := nil
]

{ #category : #'api - accessing' }
ToPaneDividerEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementAddedToParentEvent.
		  BlElementRemovedFromParentEvent }
]

{ #category : #'dnd handlers' }
ToPaneDividerEventHandler >> horizontalDragEvent: anEvent resizedElement: aResizedElement width: aWidth [

	| w divider |
	divider := anEvent currentTarget.
	(aResizedElement isHMatchParent not or: [ anEvent modifiers isShift ])
		ifTrue: [
				aResizedElement width: aWidth.
				^ self ].
	w := divider resizedElementWeightFromWidth: aWidth.
	aResizedElement constraints linear weight: w
]

{ #category : #accessing }
ToPaneDividerEventHandler >> minimumExtent [

	^ 1@1
]

{ #category : #accessing }
ToPaneDividerEventHandler >> otherResizedElementFrom: aResizedElement event: anEvent [

	| divider |
	divider := anEvent currentTarget.
	^ aResizedElement = divider firstResizedElement
		  ifTrue: [ divider secondResizedElement ]
		  ifFalse: [ divider firstResizedElement ]
]

{ #category : #'dnd handlers' }
ToPaneDividerEventHandler >> resizeBounds: aBlBounds by: aPoint onEvent: anEvent [

	| divider |
	divider := anEvent currentTarget.
	divider isHorizontal
		ifTrue: [
				aBlBounds extent:
					(aBlBounds extent + (0.0 @ aPoint y) max: self minimumExtent) ]
		ifFalse: [
				aBlBounds extent:
					(aBlBounds extent - (aPoint x @ 0.0) max: self minimumExtent) ]
]

{ #category : #'dnd handlers' }
ToPaneDividerEventHandler >> verticalDragEvent: anEvent resizedElement: aResizedElement height: aHeight [

	| w divider |
	divider := anEvent currentTarget.
	(aResizedElement isVMatchParent not or: [ anEvent modifiers isShift ])
		ifTrue: [
				aResizedElement height: aHeight.
				^ self ].
	w := divider resizedElementWeightFromHeight: aHeight.
	aResizedElement constraints linear weight: w
]
