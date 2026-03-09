Class {
	#name : #ToItemListElementForTest,
	#superclass : #ToItemListElement,
	#category : #'Toplo-Widget-Tests-List'
}

{ #category : #initialization }
ToItemListElementForTest >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeHolderFactory: [ ToItemListNodeHolderForTest new ];
		  nodeFactory: [ :holder | ToItemNodeForTest new ];
		  yourself
]
