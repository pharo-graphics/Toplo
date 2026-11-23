"
I am the common part of the events a `ToDivider` dispatches while it is dragged. I carry the Bloc drag event I come from, as `sourceEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- Divider events are separate from Bloc drag events, so that a listener hears a drag that has been accepted, and gets a delta along the axis of the divider instead of a pointer position.

## Usage

1. `ToDividerEventHandler` creates my subclasses and dispatches them on the divider: `ToDividerStartDragEvent`, then one `ToDividerDragEvent` per move, then `ToDividerEndDragEvent`.
2. Listeners on the divider handle them, for example `ToTableDividerEventHandler` resizes the columns of a table.

Each instance belongs to one event dispatch.
"
Class {
	#name : #ToDividerBaseDragEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #accessing }
ToDividerBaseDragEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToDividerBaseDragEvent >> sourceEvent: aDragEvent [

	sourceEvent := aDragEvent
]
