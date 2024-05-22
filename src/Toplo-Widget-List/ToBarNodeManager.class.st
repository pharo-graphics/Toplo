Class {
	#name : #ToBarNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent.
	  node constraintsDo: [ :c |
		  c horizontal fitContent.
		  c vertical fitContent ] ]
]

{ #category : #initialization }
ToBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBarNode new ]
]

{ #category : #accessing }
ToBarNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToBarNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #'instance creation' }
ToBarNodeManager >> newFakeNodeInHolder: anHolder [

	| fakeNode |
	anHolder dataItem: fakeDataItem.
	fakeNode := self newNodeInHolder: anHolder.
	self buildNode: fakeNode inHolder: anHolder.
	anHolder node: fakeNode.
	^ fakeNode

]
