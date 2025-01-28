Class {
	#name : #ToAccordionNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #accessing }
ToAccordionNode >> builder: aValuable [

	aValuable value: self header
]
