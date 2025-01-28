Class {
	#name : #ToAccordionListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'instance creation' }
ToAccordionListNodeManager >> buildNode: aNode [
	
	| accordionElement |
	accordionElement := aNode holder dataItem. 
	"in the case of this list the dateitem is in fact a ToAccordionElement"
	accordionElement removeFromParent. 
	aNode addChild: accordionElement at: 1
]

{ #category : #initialization }
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

	^ ToListNode new
]

{ #category : #initialization }
ToAccordionListNodeManager >> unbuildNode: aNode [

	aNode removeChildren.
	
]
