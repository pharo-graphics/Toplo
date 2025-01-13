Class {
	#name : #ToAccordionListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'instance creation' }
ToAccordionListNodeManager >> buildNode: aNode [
	
	| collapse |
	collapse := aNode holder dataItem. 
	"in the case of this list the dateitem is in fact a bl element."
	
	collapse removeFromParent. 
	aNode addChild: collapse at: 1
]

{ #category : #'instance creation' }
ToAccordionListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'instance creation' }
ToAccordionListNodeManager >> newHolder [
	"Return the holder (contains information about the node) of a node"

	^ ToListNodeHolder new
]

{ #category : #'instance creation' }
ToAccordionListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToAccordionNode new
]

{ #category : #'instance creation' }
ToAccordionListNodeManager >> unbuildNode: aNode [

	aNode removeChildren.
	
]
