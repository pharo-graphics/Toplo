Class {
	#name : #ToItemFiniteListElementForTest,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #'t - finite list element - fake container' }
ToItemFiniteListElementForTest >> defaultFakeDataItem [

	^ ToItemElementForTest new text: 'X'
]

{ #category : #initialization }
ToItemFiniteListElementForTest >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeHolderFactory: [ ToFiniteListNodeHolderForTest new ];
		  nodeFactory: [ :holder | ToItemNodeForTest new ];
		  yourself
]

{ #category : #initialization }
ToItemFiniteListElementForTest >> defaultUseInfiniteLayout [ 

	^ false
]
