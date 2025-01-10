Class {
	#name : #ToCollapseListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #'instance creation' }
ToCollapseListNodeManager >> buildNode: aNode [
	
	| collapse |
	collapse := aNode holder dataItem. 
	"in the case of this list the dateitem is in fact a bl element."
	
	collapse removeFromParent. 
	aNode addChild: collapse at: 1
]

{ #category : #'instance creation' }
ToCollapseListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'instance creation' }
ToCollapseListNodeManager >> newHolder [
	"Return the holder (contains information about the node) of a node"

	^ ToListNodeHolder new
]

{ #category : #'instance creation' }
ToCollapseListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToCollapseNode new
]

{ #category : #'instance creation' }
ToCollapseListNodeManager >> unbuildNode: aNode [

	aNode removeChildren.
	
]
