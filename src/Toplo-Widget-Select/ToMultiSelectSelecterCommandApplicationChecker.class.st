Class {
	#name : #ToMultiSelectSelecterCommandApplicationChecker,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectedIndexes'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> addIndexesSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		selectedIndexes removeAll ].
	selectedIndexes addAll: aCommand indexes
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> addIntervalSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		selectedIndexes removeAll ].
	selectedIndexes addAll: (aCommand from to: aCommand to)
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> addWholeSelectionCommand: aCommand [

	selectedIndexes addAll: (1 to: aCommand selectionModel itemCount)
]

{ #category : #'api - accessing' }
ToMultiSelectSelecterCommandApplicationChecker >> eventsToHandle [

	^ { ToListSelecterCommandApplicationRequestEvent }
]

{ #category : #'event handling' }
ToMultiSelectSelecterCommandApplicationChecker >> listSelecterCommandApplicationRequestEvent: anEvent [

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
	currentSelectElement := nil.
	request := nil
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> removeIndexesSelectionCommand: aCommand [

	selectedIndexes removeAll: aCommand indexes
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> removeIntervalSelectionCommand: aCommand [

	selectedIndexes removeAll: (aCommand from to: aCommand to)
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> removeWholeSelectionCommand: aCommand [

	selectedIndexes removeAll
]
