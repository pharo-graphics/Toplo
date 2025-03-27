Class {
	#name : #ToMenuItemNodeConfiguration,
	#superclass : #ToBarNodeConfiguration,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #hook }
ToMenuItemNodeConfiguration >> applyOn: aNode [

	super applyOn: aNode.
	aNode holder dataItem constraintMenuNode: aNode
]
