Class {
	#name : #ToTabPaneNodeManager,
	#superclass : #ToTabNodeManager,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #initialization }
ToTabPaneNodeManager >> defaultFakeDataItem [

	^ ToTabButton new
		  labelText: 'X';
		  yourself
]

{ #category : #'instance creation' }
ToTabPaneNodeManager >> newHolder [ 

	^ ToTabPaneNodeHolder new
]
