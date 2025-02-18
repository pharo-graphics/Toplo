Class {
	#name : #ToAccordionListNodeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'recyclingHandler'
	],
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #accessing }
ToAccordionListNodeHolder >> bindDataItem: aDataItem [

	super bindDataItem: aDataItem.
	recyclingHandler ifNotNil: [ ^ self ].
	recyclingHandler := self node item
		                    addEventHandlerOn: ToAccordionCheckedEvent
		                    do: [ :event |
		                    self recyclingRequested: event target isExpanded ]
]
