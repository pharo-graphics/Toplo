Class {
	#name : #ToMultiSelectHeaderSelectionChecker,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectedIndexes'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #adding }
ToMultiSelectHeaderSelectionChecker >> addIndexesSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		selectedIndexes removeAll ].
	selectedIndexes addAll: aCommand indexes
]

{ #category : #adding }
ToMultiSelectHeaderSelectionChecker >> addIntervalSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		selectedIndexes removeAll ].
	selectedIndexes addAll: (aCommand from to: aCommand to)
]

{ #category : #adding }
ToMultiSelectHeaderSelectionChecker >> addWholeSelectionCommand: aCommand [

	selectedIndexes addAll: (1 to: aCommand selectionModel itemCount)
]

{ #category : #'api - accessing' }
ToMultiSelectHeaderSelectionChecker >> eventsToHandle [

	^ { ToListSelecterCommandApplicationRequestEvent }
]

{ #category : #'event handling' }
ToMultiSelectHeaderSelectionChecker >> listSelecterCommandApplicationRequestEvent: anEvent [

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
	currentSelectElement checkMaxSelectedCountInHeader.
	currentSelectElement := nil.
	request := nil
]

{ #category : #adding }
ToMultiSelectHeaderSelectionChecker >> removeIndexesSelectionCommand: aCommand [

	selectedIndexes removeAll: aCommand indexes
]

{ #category : #adding }
ToMultiSelectHeaderSelectionChecker >> removeIntervalSelectionCommand: aCommand [

	selectedIndexes removeAll: (aCommand from to: aCommand to)
]

{ #category : #adding }
ToMultiSelectHeaderSelectionChecker >> removeWholeSelectionCommand: aCommand [

	selectedIndexes removeAll
]
