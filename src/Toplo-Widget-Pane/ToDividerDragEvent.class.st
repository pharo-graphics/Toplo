"
I tell that a `ToDivider` moved, after its `ToDividerDragRequestEvent` was accepted. I carry `delta`, the move since the start of the drag, with a zero coordinate along the divider. Handlers receive me as `dividerDragEvent:`. See `ToDividerBaseDragEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Usage

`ToDividerEventHandler>>dragEvent:` creates me in the action of the request. `ToTableDividerEventHandler` uses `delta` to resize a column.

## Invariants and Assumptions

- `delta` is relative to the start of the drag, not to the previous event.
"
Class {
	#name : #ToDividerDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#instVars : [
		'delta'
	],
	#category : #'Toplo-Widget-Pane-Core'
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
