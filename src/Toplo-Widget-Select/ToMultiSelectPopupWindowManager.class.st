Class {
	#name : #ToMultiSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#instVars : [
		'listGroupNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> defaultGroupNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToAttributedLabel text: dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder | | nodebuilder |
		nodebuilder := holder isGroup
		  ifTrue: [  listGroupNodeBuilder]
		  ifFalse: [ nodeBuilder].
	  nodebuilder value: node value: dataItem value: holder ] 
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> defaultNodeFactory [

	^ [ :theHolder |
	  theHolder isGroup
		  ifTrue: [ ToSelectGroupListNode new ]
		  ifFalse: [ ToListNode new ] ]
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> initialize [ 

	super initialize.
	nodeBuilder := self defaultDataNodeBuilder.
	listGroupNodeBuilder := self defaultGroupNodeBuilder 
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> listElementClass [

	^ ToMultiSelectListElement
]

{ #category : #accessing }
ToMultiSelectPopupWindowManager >> listGroupNodeBuilder: aValuable [

	listGroupNodeBuilder := aValuable
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> newListElement [

	| newListElement |
	newListElement := super newListElement.
	newListElement primarySelectionMode multiple: true.
	^ newListElement
]

{ #category : #'api - hooks' }
ToMultiSelectPopupWindowManager >> nodeHolderClass [

	^ ToMultiSelectListNodeHolder
]
