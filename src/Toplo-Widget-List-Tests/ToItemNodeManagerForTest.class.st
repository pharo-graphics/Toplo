Class {
	#name : #ToItemNodeManagerForTest,
	#superclass : #ToItemNodeManager,
	#category : #'Toplo-Widget-List-Tests-ItemList'
}

{ #category : #initialization }
ToItemNodeManagerForTest >> defaultFakeDataItem [

	^ ToItemElementForTest text: 'X'
]

{ #category : #'instance creation' }
ToItemNodeManagerForTest >> newHolder [

	^ ToBarNodeHolderForTest new
]

{ #category : #'instance creation' }
ToItemNodeManagerForTest >> newNodeForHolder: aNodeHolder [

	^ ToItemNodeForTest new
]
