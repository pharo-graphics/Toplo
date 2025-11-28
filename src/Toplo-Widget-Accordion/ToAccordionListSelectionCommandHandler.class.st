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
		currentTarget selectionModel allIndexesDo: [ :idx |
			self removeIndex: idx ] ].
	indexes do: [ :idx |
		(currentTarget nodeContainerAt: idx) ifNotNil: [ :container |
			container item isExpanded: true ] ]
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

{ #category : #'event handling' }
ToAccordionListSelectionCommandHandler >> listSelectionCommandAppliedEvent: aCommandAppliedEvent [
	" entry point method that launch the command handlers "

	super listSelectionCommandAppliedEvent: aCommandAppliedEvent.
	aCommandAppliedEvent selectionModel == selectionModel ifFalse: [
		^ self ].
	" have to do secondary selection update because the bounds of a node 
	can change when it is checked. Then, the secondary selection have to be updated
	but after the layout is done "
	aCommandAppliedEvent currentTarget whenLayoutedDoOnce: [
		aCommandAppliedEvent currentTarget updateSecondarySelection ]
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeAllIndexes: anIndexCollection [

	anIndexCollection do: [ :idx |
		self removeIndex: idx ]
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeIndex: anIndex [

	(currentTarget nodeContainerAt: anIndex) ifNotNil: [ :container |
		container item isExpanded: false ].
	currentTarget cleanUpRecyclerAt: anIndex
]

{ #category : #'command handling' }
ToAccordionListSelectionCommandHandler >> removeIndexesFromCommand: aCommand [

	self removeAllIndexes: aCommand indexes
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
