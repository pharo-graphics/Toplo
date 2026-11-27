"
I am the menu, at the end of a `ToTabGroupElement`, that lists the tabs that do not fit. I know my group (`tabGroupElement`).

## Examples

```
ToTabPaneElement exampleManyTabs
```

## Usage

`ToTabGroupElement>>initializeInvisibleNodesMenu` creates me, hidden, with `defaultInvisibleNodesMenuBuilder`. The group shows me when some tabs are hidden. `ToTabGroupElement>>invisibleNodesMenuBuilder:` replaces the builder.
"
Class {
	#name : #ToTabInvisibleNodesMenu,
	#superclass : #ToMenu,
	#instVars : [
		'tabGroupElement'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #skin }
ToTabInvisibleNodesMenu >> newRawSkin [

	^ ToTabInvisibleNodesMenuSkin new


]

{ #category : #accessing }
ToTabInvisibleNodesMenu >> tabGroupElement [

	^ tabGroupElement
]

{ #category : #accessing }
ToTabInvisibleNodesMenu >> tabGroupElement: aTabGroupElement [

	tabGroupElement := aTabGroupElement
]
