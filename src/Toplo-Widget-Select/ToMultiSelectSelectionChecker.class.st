Class {
	#name : #ToMultiSelectSelectionChecker,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectedIndexes'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #adding }
ToMultiSelectSelectionChecker >> addIndexesSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		selectedIndexes removeAll ].
	selectedIndexes addAll: aCommand indexes
]

{ #category : #adding }
ToMultiSelectSelectionChecker >> addIntervalSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		selectedIndexes removeAll ].
	selectedIndexes addAll: (aCommand from to: aCommand to)
]

{ #category : #adding }
ToMultiSelectSelectionChecker >> addWholeSelectionCommand: aCommand [

	selectedIndexes addAll: (1 to: aCommand selectionModel itemCount)
]

{ #category : #'api - accessing' }
ToMultiSelectSelectionChecker >> eventsToHandle [

	^ { ToListSelecterCommandApplicationRequestEvent }
]

{ #category : #'event handling' }
ToMultiSelectSelectionChecker >> listSelecterCommandApplicationRequestEvent: anEvent [

	| request command currentSelectElement |
	request := anEvent.
	currentSelectElement := anEvent currentTarget.
	" check that the command is applied on the primary selection model "
	request selectionModel == currentSelectElement selectionModel
		ifFalse: [ ^ self ].
	currentSelectElement haveMaxSelectedCount ifFalse: [ ^ self ].
	command := request command.
	selectedIndexes := command selectionModel selectedIndexes
		                   asSet.
	command applyWithOperator: self.
	selectedIndexes size > currentSelectElement maxSelectedCount ifTrue: [
		request deny ].
	currentSelectElement updateSelectedCountLabelInHeader.
	currentSelectElement := nil.
	request := nil
]

{ #category : #adding }
ToMultiSelectSelectionChecker >> removeIndexesSelectionCommand: aCommand [

	selectedIndexes removeAll: aCommand indexes
]

{ #category : #adding }
ToMultiSelectSelectionChecker >> removeIntervalSelectionCommand: aCommand [

	selectedIndexes removeAll: (aCommand from to: aCommand to)
]

{ #category : #adding }
ToMultiSelectSelectionChecker >> removeWholeSelectionCommand: aCommand [

	selectedIndexes removeAll
]
