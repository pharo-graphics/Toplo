Class {
	#name : #ToAccordionItemElement,
	#superclass : #ToAccordionAbstractElement,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionItemElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst
		addEventHandlerOn: BlClickEvent
		do: [ :evt | inst privateSwitchExpanded ].
	inst openInSpace.
	^ inst
]

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

	^ ToAccordionBaseElementSkin new
]
