"
I ask whether a drag of a `ToDivider` may start. Handlers receive me as `dividerDragStartRequestEvent:`. See `ToDividerRequestEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Usage

`ToDividerEventHandler>>dragStartEvent:` creates me. My action dispatches `ToDividerStartDragEvent`.

## Implementation Notes

- The selector handlers receive me as, `dividerDragStartRequestEvent:`, does not follow the word order of my class name.
"
Class {
	#name : #ToDividerStartDragRequestEvent,
	#superclass : #ToDividerRequestEvent,
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #sending }
ToDividerStartDragRequestEvent >> sendTo: anObject [

	anObject dividerDragStartRequestEvent: self
]
