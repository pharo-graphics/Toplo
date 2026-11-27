"
I tell that a drag of a `ToDivider` starts, after its `ToDividerStartDragRequestEvent` was accepted. Handlers receive me as `dividerStartDragEvent:`. See `ToDividerBaseDragEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Usage

`ToDividerEventHandler>>dragStartEvent:` creates me. `ToTableDividerEventHandler` uses me to remember the position at which the drag started.
"
Class {
	#name : #ToDividerStartDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #sending }
ToDividerStartDragEvent >> sendTo: anObject [

	anObject dividerStartDragEvent: self
]
