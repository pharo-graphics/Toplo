"
I am a menu item for a hidden tab. I know its node (`tabNode`), so that the skin can tell whether the tab is selected, and clicking me selects the tab.

## Examples

```
ToTabPaneElement exampleManyTabs
```

## Usage

`ToTabGroupElement>>defaultInvisibleNodesMenuBuilder` creates one of me for each enabled hidden tab, and the block of `invisibleNodeMenuItemBuilder:` configures me, by default with the label of the tab.
"
Class {
	#name : #ToTabInvisibleNodeMenuItem,
	#superclass : #ToMenuItem,
	#instVars : [
		'tabNode'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #skin }
ToTabInvisibleNodeMenuItem >> newRawSkin [ 

	^ ToTabInvisibleNodeMenuItemSkin new
]

{ #category : #accessing }
ToTabInvisibleNodeMenuItem >> tabNode [

	^ tabNode
]

{ #category : #accessing }
ToTabInvisibleNodeMenuItem >> tabNode: aTabNode [

	tabNode := aTabNode
]
