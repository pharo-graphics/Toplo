Class {
	#name : #ToAccordionListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #initialization }
ToAccordionListElement >> defaultNodeManagerClass [
	"The object responsible to populate the list nodes."

	^ ToAccordionListNodeManager 
]

{ #category : #initialization }
ToAccordionListElement >> initialize [

	super initialize.
	self addEventHandler:
		(ToAccordionListSelectionCommandHandler new
			 selectionModel: self selectionModel;
			 yourself).
	self selectionOption withEmbeddedRepresentation
]

{ #category : #initialization }
ToAccordionListElement >> itemBuilder: aValuable [
	" aValuable has 3 arguments: the ccordionElement (the item), the data and the holder "

	self nodeManager itemBuilder: aValuable
]

{ #category : #initialization }
ToAccordionListElement >> itemFactory: aValuable [
	" aValuable has the node as argument"

	self nodeManager itemFactory: aValuable
]
