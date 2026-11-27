"
I am the node of a tab of a tab pane. I differ from `ToTabNode` by my skin.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToTabPaneListElement>>defaultNodeManager` creates me.
"
Class {
	#name : #ToTabPaneNode,
	#superclass : #ToTabNode,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'t - item node' }
ToTabPaneNode >> newRawSkin [ 

	^ ToTabPaneNodeSkin new
]
