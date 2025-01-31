Class {
	#name : #ToAccordionListNodeManager,
	#superclass : #ToCheckableItemNodeManager,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #'t - generic node manager' }
ToAccordionListNodeManager >> newHolder [

	^ ToAccordionListNodeHolder new
]

{ #category : #'t - generic node manager' }
ToAccordionListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToAccordionListNode new
]
