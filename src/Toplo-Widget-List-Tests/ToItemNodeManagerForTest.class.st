Class {
	#name : #ToItemNodeManagerForTest,
	#superclass : #ToItemFiniteListNodeManager,
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #'instance creation' }
ToItemNodeManagerForTest >> newHolder [

	^ ToFiniteListNodeHolderForTest new
]

{ #category : #'instance creation' }
ToItemNodeManagerForTest >> newNodeForHolder: aNodeHolder [

	^ ToItemNodeForTest new
]
