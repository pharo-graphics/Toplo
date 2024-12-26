Class {
	#name : #ToMenuItemNodeManager,
	#superclass : #ToItemNodeManager,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #initialization }
ToMenuItemNodeManager >> constraintNode: aNode [

	super constraintNode: aNode.
	aNode holder dataItem constraintMenuNode: aNode.

]

{ #category : #'instance creation' }
ToMenuItemNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToMenuItemNode new
]
