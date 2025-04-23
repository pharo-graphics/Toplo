Class {
	#name : #ToAccordionListNode,
	#superclass : #ToListNode,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #accessing }
ToAccordionListNode >> item [

	^ item
]

{ #category : #accessing }
ToAccordionListNode >> item: anAccordionElement [

	item = anAccordionElement ifTrue: [ ^ self ].
	item ifNotNil: [ item removeFromParent ].
	item := anAccordionElement.
	self addChild: item at: 1
]
