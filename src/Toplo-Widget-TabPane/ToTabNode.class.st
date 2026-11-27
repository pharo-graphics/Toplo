"
I am the node of a tab in a `ToTabListElement`: I hold the tab item, and its remove button when the item is removable.

## Examples

```
ToTabPaneElement exampleRemovableTabs
```

## Usage

The node manager of the list (`ToTabListElement>>defaultNodeManager`) creates me. I add or remove my remove button when I am configured, after `isRemovable` of my item. A click on it fires a `ToRemoveButtonClickedEvent`.
"
Class {
	#name : #ToTabNode,
	#superclass : #ToListCheckableNode,
	#traits : 'TToRemovableNode',
	#classTraits : 'TToRemovableNode classTrait',
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #configuration }
ToTabNode >> applyConfiguration [

	super applyConfiguration.
	self isRemovable
		ifTrue: [ self addRemoveButton ]
		ifFalse: [ self removeRemoveButton ].
	self requestNewSkin
]

{ #category : #'t - item node' }
ToTabNode >> newRawSkin [ 

	^ ToTabNodeSkin new
]
