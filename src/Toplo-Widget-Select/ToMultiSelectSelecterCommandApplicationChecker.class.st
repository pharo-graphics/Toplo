Class {
	#name : #ToMultiSelectSelecterCommandApplicationChecker,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'currentSelectElement',
		'request'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> addIndexesSelectionCommand: aCommand [

	| n |
	n := currentSelectElement header dataAccessor size.
	aCommand operation deselectAllBefore ifTrue: [ n := 0 ].
	n := n + aCommand indexes size.
	n traceCr.
	n + currentSelectElement header dataAccessor size
	> currentSelectElement maxSelectedCount ifTrue: [ request deny ]
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> addIntervalSelectionCommand: aCommand [

	| n |
	currentSelectElement header dataAccessor collection traceCr.
	n := currentSelectElement header dataAccessor size.
	aCommand operation deselectAllBefore ifTrue: [ n := 0 ].
	n := n + aCommand to - aCommand from + 1.
	n traceCr.
	n + currentSelectElement header dataAccessor size
	> currentSelectElement maxSelectedCount ifTrue: [ request deny ]
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> addWholeSelectionCommand: aCommand [


]

{ #category : #'api - accessing' }
ToMultiSelectSelecterCommandApplicationChecker >> eventsToHandle [

	^ { ToListSelecterCommandApplicationRequestEvent }
]

{ #category : #'event handling' }
ToMultiSelectSelecterCommandApplicationChecker >> listSelecterCommandApplicationRequestEvent: anEvent [

	currentSelectElement := anEvent currentTarget.
	request := anEvent.
	request selectionModel = currentSelectElement selectionModel
		ifFalse: [ ^ self ].
	" check that the command is applied on the primary selection model "
	request selectionModel == currentSelectElement selectionModel
		ifFalse: [ ^ self ].
	request command applyWithOperator: self.
	currentSelectElement := nil.
	request := nil
]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> removeIntervalSelectionCommand: aCommand [


]

{ #category : #adding }
ToMultiSelectSelecterCommandApplicationChecker >> removeWholeSelectionCommand: aCommand [

]
