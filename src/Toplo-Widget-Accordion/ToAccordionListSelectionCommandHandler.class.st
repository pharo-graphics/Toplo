Class {
	#name : #ToAccordionListSelectionCommandHandler,
	#superclass : #ToListSelectionCommandHandler,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> addIndexesFromCommand: aCommand [

	| indexes |
	indexes := aCommand indexes.
	aCommand operation deselectAllBefore ifTrue: [
		currentTarget nodesDo: [ :node |
			(indexes includes: node holder position) ifFalse: [
				node item isExpanded: false ] ] ].
	indexes do: [ :idx |
		(currentTarget nodeAt: idx) ifNotNil: [ :node |
			node item isExpanded: true ] ]
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> addIndexesSelectionCommand: aCommand [

	self addIndexesFromCommand: aCommand
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> addIntervalSelectionCommand: aCommand [

	self addIndexesFromCommand: aCommand
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> addWholeSelectionCommand: aCommand [

	self addIndexesFromCommand: aCommand
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeIndexesFromCommand: aCommand [

	| indexes |
	indexes := aCommand indexes.
	indexes do: [ :idx |
		(currentTarget nodeAt: idx) ifNotNil: [ :node |
			node item isExpanded: false ] ]
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeIndexesSelectionCommand: aCommand [

	self removeIndexesFromCommand: aCommand
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeIntervalSelectionCommand: aCommand [

	self removeIndexesFromCommand: aCommand
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeWholeSelectionCommand: aCommand [

	self removeIndexesFromCommand: aCommand
]
