Class {
	#name : #ToLinearBarNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToLinearBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent.
	  node constraintsDo: [ :c |
		  c horizontal fitContent.
		  c vertical fitContent ] ]
]

{ #category : #accessing }
ToLinearBarNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToLinearBarNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #'instance creation' }
ToLinearBarNodeManager >> newFakeNodeInHolder: anHolder [

	| fakeNode |
	anHolder dataItem: fakeDataItem.
	fakeNode := self newNodeInHolder: anHolder.
	self buildNode: fakeNode inHolder: anHolder.
	anHolder node: fakeNode.
	^ fakeNode

]
