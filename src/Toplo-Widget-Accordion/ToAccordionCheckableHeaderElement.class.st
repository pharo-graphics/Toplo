Class {
	#name : #ToAccordionCheckableHeaderElement,
	#superclass : #ToAccordionHeaderElement,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #initialization }
ToAccordionCheckableHeaderElement >> initialize [ 

	super initialize.
	self initializeAsCheckable
]

{ #category : #testing }
ToAccordionCheckableHeaderElement >> isExpanded [ 

	^ self isChecked
]
