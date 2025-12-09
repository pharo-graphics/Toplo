Class {
	#name : #ToTabNodeManager,
	#superclass : #ToCheckableFiniteListNodeManager,
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #'instance creation' }
ToTabNodeManager >> newHolder [ 

	^ ToTabNodeHolder new
]

{ #category : #'instance creation' }
ToTabNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTabNode new
]
