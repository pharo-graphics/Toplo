Class {
	#name : #ToItemNodeManagerForTest,
	#superclass : #ToItemFiniteListNodeManager,
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #initialization }
ToItemNodeManagerForTest >> defaultNodeFactory [

	^ [ :holder | ToFiniteListNodeHolderForTest new ]
]

{ #category : #initialization }
ToItemNodeManagerForTest >> defaultNodeHolderFactory [ 

	^ [ ToFiniteListNodeHolderForTest new ] 
]
