Class {
	#name : #ToMenuItemNodeManager,
	#superclass : #ToItemBarNodeManager,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #initialization }
ToMenuItemNodeManager >> applyNodeConstraintsOn: aNode [

	aNode holder dataItem constraintMenuNode: aNode.

]

{ #category : #'instance creation' }
ToMenuItemNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToMenuItemNode new
]
