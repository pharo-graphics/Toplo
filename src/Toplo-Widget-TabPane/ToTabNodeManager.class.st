Class {
	#name : #ToTabNodeManager,
	#superclass : #ToCheckableBarNodeManager,
	#category : #'Toplo-Widget-TabPane-TabBar'
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
