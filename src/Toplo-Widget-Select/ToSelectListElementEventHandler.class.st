Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ {
		  ToSieveSelectionChangedEvent }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement sieve |
	listElement := anEvent currentTarget.
	sieve := select sieve.
	listElement dataAccessor withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := sieve dataPositionIndex at: d.
		listElement selectionModel
			transferSelectionFromIndex: localIndex
			toIndex: originalIndex
			in: select selectionModel ].
	select onSelectionChangedInListElement
]
