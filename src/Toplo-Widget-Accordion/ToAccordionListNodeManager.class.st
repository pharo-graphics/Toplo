Class {
	#name : #ToAccordionListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #'instance creation' }
ToAccordionListNodeManager >> newHolder [

	^ ToAccordionListNodeHolder new
]

{ #category : #'instance creation' }
ToAccordionListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToAccordionListNode new
]
