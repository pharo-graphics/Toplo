Class {
	#name : #ToAccordionItemElement,
	#superclass : #ToAccordionAbstractElement,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #testing }
ToAccordionItemElement >> isExpanded [
	
	^ header isExpanded 
]

{ #category : #accessing }
ToAccordionItemElement >> isExpanded: aBoolean [
	
	self isExpanded = aBoolean ifTrue: [ ^ self ].
	header isExpanded: aBoolean.
	self privateExpanded: aBoolean
]

{ #category : #'instance creation' }
ToAccordionItemElement >> newHeader [ 

	^ ToAccordionItemHeaderElement new
]

{ #category : #'instance creation' }
ToAccordionItemElement >> newRawSkin [ 

	^ ToAccordionElementSkin new
]
