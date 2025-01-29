Class {
	#name : #ToAccordionListNodeManager,
	#superclass : #ToGenericListNodeManager,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'t - generic node manager' }
ToAccordionListNodeManager >> newHolder [

	^ ToListNodeHolder new
]

{ #category : #'t - generic node manager' }
ToAccordionListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToAccordionListNode new
]
