"
I am the common part of the events about the placeholder of an element. I carry the `placeholder` layer. `ToPlaceholderShownEvent` is my only subclass.

## Examples

```
ToPlaceholderLayer exampleDefault
```

## Usage

`TToElementWithPlaceholder>>showPlaceholder` creates my subclass and dispatches it on the element that has the placeholder.
"
Class {
	#name : #ToPlaceholderEvent,
	#superclass : #BlEvent,
	#instVars : [
		'placeholder'
	],
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #accessing }
ToPlaceholderEvent >> placeholder [

	^ placeholder 
]

{ #category : #accessing }
ToPlaceholderEvent >> placeholder: aPlaceholder [

	placeholder := aPlaceholder
]
