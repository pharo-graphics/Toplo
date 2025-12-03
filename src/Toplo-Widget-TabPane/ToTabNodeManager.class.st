Class {
	#name : #ToTabNodeManager,
	#superclass : #ToCheckableFiniteListNodeManager,
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #initialization }
ToTabNodeManager >> defaultFakeDataItem [

	^ ToTabItemElement new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToTabNodeManager >> newHolder [ 

	^ ToTabNodeHolder new
]

{ #category : #'instance creation' }
ToTabNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTabNode new
]
