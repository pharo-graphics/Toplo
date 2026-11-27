"
I am a layer that covers an element to show a placeholder: what the element displays when it has no content yet. I am an overlay, so I do not take part in the layout of the content of the element.

## Examples

```
ToPlaceholderLayer exampleDefault
```

## Design Rationale

- The content of the placeholder is free: the builder block given to `placeholderBuilder:` receives me and fills me. `placeholderString:` and `placeholderText:` are shortcuts for a label.
- The element chooses my elevation with `placeholderElevation`, its own elevation by default.

## Usage

1. `TToElementWithPlaceholder>>newPlaceholder` creates me, from `placeholderBuilder:`, and attaches me to the element, hidden. Elements choose my class with `placeholderClass`: lists answer `ToEmptyPlaceholderLayer`.
2. `showPlaceholder` makes me visible and dispatches a `ToPlaceholderShownEvent`; `hidePlaceholder` hides me. Lists do it when they become empty or not (`ToListElementEventHandler>>showHidePlaceholderIn:`).
3. `TToPasteUpPane` uses me in another way, as the layer that shows an element while it is dragged.
4. A new `placeholderBuilder:` detaches me and replaces me; a nil builder only detaches me.
"
Class {
	#name : #ToPlaceholderLayer,
	#superclass : #ToOverlayElement,
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #examples }
ToPlaceholderLayer class >> exampleDefault [
	"An empty pane showing its placeholder, a layer that covers it."

	<example>
	| pane |
	pane := ToPane new matchParent.
	pane placeholderString: 'Nothing here yet'.
	pane showPlaceholder.
	^ pane openInSpace
]

{ #category : #instances }
ToPlaceholderLayer class >> instanceDefault [

	<sampleInstance>
	^ self new
]

{ #category : #initialization }
ToPlaceholderLayer >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToPlaceholderLayer >> initialize [ 

	super initialize.
	self layout: self defaultLayout
	
]

{ #category : #skin }
ToPlaceholderLayer >> newRawSkin [ 

	^ ToPlaceholderLayerSkin new
]
