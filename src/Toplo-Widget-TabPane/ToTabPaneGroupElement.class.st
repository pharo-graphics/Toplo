"
I am the tab group of a `ToTabPaneElement`: my tabs are `ToTabButton`s, which build a pane, in a `ToTabPaneListElement`. See `ToTabGroupElement` for the rest.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToTabPaneHeaderElement>>newTabGroupElement` creates me. `ToTabPaneElement>>tabGroup` answers me.
"
Class {
	#name : #ToTabPaneGroupElement,
	#superclass : #ToTabGroupElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #initialization }
ToTabPaneGroupElement >> defaultTabItemFactory [

	^ [ ToTabButton new ]
]

{ #category : #initialization }
ToTabPaneGroupElement >> listElementClass [

	^ ToTabPaneListElement 
]
