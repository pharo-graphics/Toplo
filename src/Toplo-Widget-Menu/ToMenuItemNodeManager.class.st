Class {
	#name : #ToMenuItemNodeManager,
	#superclass : #ToItemNodeManager,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuItemNodeManager >> constraintNode: aNode [

	super constraintNode: aNode.
	aNode holder dataItem constraintMenuNode: aNode.

]
