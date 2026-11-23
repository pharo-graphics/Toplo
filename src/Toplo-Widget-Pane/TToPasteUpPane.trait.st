"
I let the user drag the children of a pane anywhere in it.

`initializeAsPasteUp` installs the drag on the pane. While it is dragged, a child is moved to a layer over the pane, and it comes back to the pane when the drag ends.

## Examples

```
ToPane examplePasteUp
```

## Design Rationale

- The dragged child moves to a `ToPlaceholderLayer` so that it is shown over its siblings and no longer takes part in the layout of the pane. The layer ignores mouse events, so the pointer still reaches what is under it.
- I am a trait: free dragging is a behavior a pane opts into, not a kind of pane.

## Usage

`ToPane` uses me. A client sends `initializeAsPasteUp` to a pane, once, usually after giving it a `BlBasicLayout`, so that the children keep the position where they are dropped. With a linear layout they go back to the place of the last child.

## Implementation Notes

- My state (the layer, the gap between the pointer and the child) is in the `userData` of the pane: `pasteUpField` fails on a pane that did not receive `initializeAsPasteUp`.
"
Trait {
	#name : #TToPasteUpPane,
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> draggedElement [

	^ self pasteUpField ifNotNil: [ :field |
		  field hasChildren
			  ifTrue: [ field firstChild ]
			  ifFalse: [  ] ]
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> initialGap [

	^ self userData at: #initialGap ifAbsent: [ 0 ]
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> initialGap: anInteger [

	self userData at: #initialGap put: anInteger
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> initializeAsPasteUp [

	| field |
	field := ToPlaceholderLayer new.
	field layout: BlBasicLayout new.
	field preventMeAndChildrenMouseEvents.
	self pasteUpField: field.
	field attachTo: self.
	self addChild: field.
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		| dragged |
		event consume.
		dragged := self findMouseEventTargetAt: event position.
		(dragged notNil and: [ dragged ~= self ]) ifTrue: [
			self initialGap: event position - dragged position.
			self removeChild: dragged.
			field addChild: dragged ] ].
	self addEventHandlerOn: BlDragEvent do: [ :event |
		event consume.
		self draggedElement ifNotNil: [ :dragged |
			dragged position: event position - self initialGap ] ].
	self addEventHandlerOn: BlDragEndEvent do: [ :event |
		event consume.
		self draggedElement ifNotNil: [ :dragged |
			dragged position: event position - self initialGap.
			field removeChild: dragged.
			self addChild: dragged ] ]
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> pasteUpField [

	^ self userData at: #pasteUpField
]

{ #category : #'t - paste-up pane' }
TToPasteUpPane >> pasteUpField: aLayer [

	self userData at: #pasteUpField put: aLayer
]
