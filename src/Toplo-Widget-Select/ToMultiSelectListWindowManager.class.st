Class {
	#name : #ToMultiSelectListWindowManager,
	#superclass : #ToSelectListWindowManager,
	#instVars : [
		'listGroupNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultGroupNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToAttributedLabel text: dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder | | nodebuilder |
		nodebuilder := holder isGroup
		  ifTrue: [  listGroupNodeBuilder]
		  ifFalse: [ listDataNodeBuilder].
	  nodebuilder value: node value: dataItem value: holder ] 
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultNodeFactory [

	^ [ :theHolder |
	  theHolder isGroup
		  ifTrue: [ ToSelectGroupListNode new ]
		  ifFalse: [ ToSelectDataListNode new ] ]
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> initialize [ 

	super initialize.
	listDataNodeBuilder := self defaultDataNodeBuilder.
	listGroupNodeBuilder := self defaultGroupNodeBuilder 
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> listElementClass [

	^ ToMultiSelectListElement
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> listGroupNodeBuilder: aValuable [

	listGroupNodeBuilder := aValuable
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> newListElement [

	| newListElement |
	newListElement := super newListElement.
	newListElement primarySelectionMode multiple: true.
	^ newListElement
]

{ #category : #'api - hooks' }
ToMultiSelectListWindowManager >> nodeHolderClass [

	^ ToMultiSelectListNodeHolder
]
