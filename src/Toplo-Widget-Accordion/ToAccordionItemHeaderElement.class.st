Class {
	#name : #ToAccordionItemHeaderElement,
	#superclass : #ToAccordionHeaderElement,
	#instVars : [
		'isExpanded'
	],
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #initialization }
ToAccordionItemHeaderElement >> initialize [ 

	super initialize.
	isExpanded := false
]

{ #category : #testing }
ToAccordionItemHeaderElement >> isExpanded [
	
	^ isExpanded 
]

{ #category : #testing }
ToAccordionItemHeaderElement >> isExpanded: aBoolean [
	
	isExpanded := aBoolean
]
