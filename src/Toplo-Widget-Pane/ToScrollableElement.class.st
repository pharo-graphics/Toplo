"
I am the element that makes another one scrollable in Toplo. I am a `BlScrollableElement` with the behavior of a Toplo element (`TToElement`).

## Examples

```
ToScrollableElement exampleTallPane
```

## Design Rationale

- `layoutFixGap:` does nothing: the superclass version makes the scrolling behave strangely when a child is removed, until the top or the left is reached.

## Usage

`BlElement>>asScrollableElement` creates me around a Toplo element, because `TToElement>>newScrollableParent` answers me. `ToScrollableFiniteListElement` is my subclass for lists.

A client that wants the mouse wheel to scroll me also attaches a scrollbar to me (`ToScrollbarElement>>attachTo:`) or listens to `BlElementScrolledEvent`. Without such a listener the wheel does nothing, although `scrollBy:` scrolls me.

## Implementation Notes

- My event handler sends me `mouseWheelEvent:` after scrolling. It is an empty hook for subclasses.
"
Class {
	#name : #ToScrollableElement,
	#superclass : #BlScrollableElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'private - demo' }
ToScrollableElement class >> demoWithScrollbar: aScrollableElement [
	"Answer a container showing the element with a vertical scrollbar attached to it. The scrollbar listens to the scrolled events, which the mouse wheel requires."

	| scrollbar |
	scrollbar := ToScrollbarElement new.
	scrollbar constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	scrollbar attachTo: aScrollableElement.
	^ BlElement new
		  matchParent;
		  addChildren: {
			  aScrollableElement.
			  scrollbar };
		  yourself
]

{ #category : #examples }
ToScrollableElement class >> exampleTallPane [
	"A pane taller than its window, scrolled with the mouse wheel or the scrollbar."

	<example>
	^ (self demoWithScrollbar: self instanceTallPane) openInSpace
]

{ #category : #instances }
ToScrollableElement class >> instanceTallPane [

	<sampleInstance>
	| pane |
	pane := ToPane vertical.
	pane hMatchParent.
	pane vFitContent.
	1 to: 100 do: [ :index | pane addChild: (ToLabel text: ('Line {1}' format: { index })) ].
	^ self new
		  matchParent;
		  addChild: pane;
		  yourself
]

{ #category : #initialization }
ToScrollableElement >> defaultEventHandler [

	^ ToScrollableElementEventHandler new
]

{ #category : #layout }
ToScrollableElement >> layoutFixGap: aLayoutNode [

	self flag: 'One have to investigate the usefulness of this method in the superclass'.
	" do nothing here, else the scrollable element layouting can behave strangly when removing a node (the layout turn in a strange scrolling mode until the top or the left is reached )"
]

{ #category : #'mouse handlers' }
ToScrollableElement >> mouseWheelEvent: anEvent [
]
