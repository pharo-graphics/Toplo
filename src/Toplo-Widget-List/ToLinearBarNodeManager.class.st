Class {
	#name : #ToLinearBarNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#instVars : [
		'fakeDataItem',
		'fakeNode'
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

{ #category : #accessing }
ToLinearBarNodeManager >> fakeNode [

	^ fakeNode
]

{ #category : #accessing }
ToLinearBarNodeManager >> fakeNode: aNode [

	fakeNode := aNode
]
