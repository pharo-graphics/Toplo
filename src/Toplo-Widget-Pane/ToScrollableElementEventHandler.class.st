"
I am the event handler of a `ToScrollableElement`. I let the mouse wheel scroll only when something listens to the `BlElementScrolledEvent` of the element (`wantsScrolledEvent`), for example an attached scrollbar, then tell the element with `mouseWheelEvent:`.

## Examples

```
ToScrollableElement exampleTallPane
```

## Usage

`ToScrollableElement>>defaultEventHandler` creates me. `ToCircularListElement>>initialize` also adds me to circular lists.
"
Class {
	#name : #ToScrollableElementEventHandler,
	#superclass : #BlScrollableElementEventHandler,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'mouse handlers' }
ToScrollableElementEventHandler >> mouseWheelEvent: anEvent [
	
	anEvent currentTarget eventDispatcher wantsScrolledEvent ifFalse: [
		^ self ].
	super mouseWheelEvent: anEvent.
	anEvent currentTarget mouseWheelEvent: anEvent
]
