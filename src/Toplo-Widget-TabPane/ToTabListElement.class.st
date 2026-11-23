"
I am the list of the tabs of a `ToTabGroupElement`: a checkable list, with nodes that can hold a remove button.

`atStartSide:` tells on which side of the content the tabs are, which decides the edge where the selection is drawn.

## Examples

```
ToTabListElement exampleTabs
```

## Design Rationale

- I use a fake node (`TToListFakeNodeUser`) so that a group without tabs keeps the height of one. `defaultFakeDataItem` gives its content.
- The selection is drawn beneath the tabs, one element per tab.

## Usage

1. `ToTabGroupElement>>newMiddleContainer` creates me, with the class of `listElementClass`; `ToTabGroupElement>>itemList` answers me. I can also be used alone, with `addItem:`.
2. My nodes are created by my node manager as `ToTabNode`s.
3. `ToTabListInTabGroupEventHandler` listens to my selection, to the items, and to the nodes that become visible or hidden.
"
Class {
	#name : #ToTabListElement,
	#superclass : #ToCheckableListElement,
	#traits : 'TToListFakeNodeUser',
	#classTraits : 'TToListFakeNodeUser classTrait',
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #examples }
ToTabListElement class >> exampleTabs [
	"A horizontal list of three tab items."

	<example>
	^ self instanceWithTabs openInSpace
]

{ #category : #instances }
ToTabListElement class >> instanceWithTabs [

	<sampleInstance>
	| list |
	list := self new hMatchParent.
	list vFitContent.
	list horizontal: true.
	list addAllItems: (#( 'Daily' 'Weekly' 'Monthly' ) collect: [ :label |
		 ToTabItemElement new
			 labelText: label;
			 yourself ]).
	^ list
]

{ #category : #accessing }
ToTabListElement >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabListElement >> atStartSide: aBoolean [

	atStartSide = aBoolean ifTrue: [ ^ self ].
	atStartSide := aBoolean.
	self requestConfiguration
]

{ #category : #'t - list fake node user' }
ToTabListElement >> defaultFakeDataItem [

	^ ToTabItemElement new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToTabListElement >> defaultInnerElementClass [

	^ ToScrollableFiniteListElement
]

{ #category : #initialization }
ToTabListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToTabNode new ];
		  yourself
]

{ #category : #initialization }
ToTabListElement >> initialize [ 

	super initialize.
	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true.
	atStartSide := true
]

{ #category : #testing }
ToTabListElement >> isAtEndSide [ 

	^ self isAtStartSide not
]

{ #category : #testing }
ToTabListElement >> isAtStartSide [

	^ atStartSide
]

{ #category : #skin }
ToTabListElement >> newRawSkin [ 

	^ ToTabListElementSkin new
]
