Class {
	#name : #ToItemListElementForTest,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #'t - finite list element - fake container' }
ToItemListElementForTest >> defaultFakeDataItem [

	^ ToItemElementForTest new text: 'X'
]

{ #category : #initialization }
ToItemListElementForTest >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeHolderFactory: [ ToItemListNodeHolderForTest new ];
		  nodeFactory: [ :holder | ToItemNodeForTest new ];
		  yourself
]
