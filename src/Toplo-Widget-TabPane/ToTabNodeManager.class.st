Class {
	#name : #ToTabNodeManager,
	#superclass : #ToCheckableFiniteListNodeManager,
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #initialization }
ToTabNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToTabNode new ]
]

{ #category : #initialization }
ToTabNodeManager >> defaultNodeHolderFactory [ 

	^ [  ToTabNodeHolder new ]
]
