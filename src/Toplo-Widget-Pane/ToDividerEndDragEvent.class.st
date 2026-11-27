"
I tell that a drag of a `ToDivider` ended. Handlers receive me as `dividerEndDragEvent:`. See `ToDividerBaseDragEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- The end of a drag is not negotiated: there is no request before me, and I am dispatched even when requests were denied.

## Usage

`ToDividerEventHandler>>dragEndEvent:` creates me. `ToTableDividerEventHandler` uses me to update the dividers of its table.
"
Class {
	#name : #ToDividerEndDragEvent,
	#superclass : #ToDividerBaseDragEvent,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #sending }
ToDividerEndDragEvent >> sendTo: anObject [

	anObject dividerEndDragEvent: self
]
