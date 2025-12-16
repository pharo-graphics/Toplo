Class {
	#name : #ToTabPaneNodeManager,
	#superclass : #ToTabNodeManager,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #initialization }
ToTabPaneNodeManager >> defaultNodeHolderFactory [ 

	^ [  ToTabPaneNodeHolder new ]
]
