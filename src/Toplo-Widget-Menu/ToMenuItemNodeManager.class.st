Class {
	#name : #ToMenuItemNodeManager,
	#superclass : #ToItemFiniteListNodeManager,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'instance creation' }
ToMenuItemNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToMenuItemNode new
]
