"
I ask whether a `ToDivider` may move. I carry `delta`, the move since the start of the drag. Handlers receive me as `dividerDragRequestEvent:`. See `ToDividerRequestEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Usage

`ToDividerEventHandler>>dragEvent:` creates me. My action moves the divider and dispatches `ToDividerDragEvent`. A listener can use `delta` to refuse a move that goes too far.

## Implementation Notes

- For a `ToPaneDivider`, denying me does not stop the resizing of its two elements. This is a known issue.
"
Class {
	#name : #ToDividerDragRequestEvent,
	#superclass : #ToDividerRequestEvent,
	#instVars : [
		'delta'
	],
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #accessing }
ToDividerDragRequestEvent >> delta [

	^ delta
]

{ #category : #accessing }
ToDividerDragRequestEvent >> delta: aPoint [

	delta := aPoint
]

{ #category : #sending }
ToDividerDragRequestEvent >> sendTo: anObject [

	anObject dividerDragRequestEvent: self
]
