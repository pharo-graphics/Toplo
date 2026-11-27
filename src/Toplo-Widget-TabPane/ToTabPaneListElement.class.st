"
I am the list of the tabs of a tab pane. My nodes are `ToTabPaneNode`s and my skin draws the selection as a bar along the body. See `ToTabListElement` for the rest.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToTabPaneGroupElement>>listElementClass` answers me.
"
Class {
	#name : #ToTabPaneListElement,
	#superclass : #ToTabListElement,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'t - list fake node user' }
ToTabPaneListElement >> defaultFakeDataItem [

	^ ToTabButton new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToTabPaneListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToTabPaneNode new ];
		  yourself
]

{ #category : #skin }
ToTabPaneListElement >> newRawSkin [ 

	^ ToTabPaneListElementSkin new
]
