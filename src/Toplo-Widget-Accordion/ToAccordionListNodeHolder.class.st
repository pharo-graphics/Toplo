Class {
	#name : #ToAccordionListNodeHolder,
	#superclass : #ToItemBarNodeHolder,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #accessing }
ToAccordionListNodeHolder >> initializeNode [

	super initializeNode.
	self dataItem itemConstraintsDo: [ :ic |
		self dataItem isExpanded ifTrue: [
			self listElement selecter selectIndex: self position ] ]
]
