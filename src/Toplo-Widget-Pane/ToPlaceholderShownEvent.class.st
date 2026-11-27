"
I tell that an element shows its placeholder, so that a client can fill or animate it only then. Handlers receive me as `placeHolderShownEvent:` (with a capital H). See `ToPlaceholderEvent`.

## Examples

```
ToPlaceholderLayer exampleDefault
```

## Usage

`TToElementWithPlaceholder>>showPlaceholder` creates me after making the layer visible. Hiding the placeholder dispatches nothing.
"
Class {
	#name : #ToPlaceholderShownEvent,
	#superclass : #ToPlaceholderEvent,
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #sending }
ToPlaceholderShownEvent >> sendTo: anObject [

	anObject placeHolderShownEvent: self
]
