Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> collectionFilteredEvent: anEvent [

	| listElement visibleIdxes |
	listElement := select listElement.
	select isMultipleSelection ifFalse: [
		listElement secondarySelectionModel deselectAll ].

	select hideSelected ifFalse: [ ^ self ].
	visibleIdxes := Array streamContents: [ :stream |
		                listElement dataAccessor withIndexDo: [ :d :localIndex |
			                (listElement selectionModel containsIndex:
				                 localIndex)
				                ifTrue: [
				                listElement selectionModel hideIndex: localIndex ]
				                ifFalse: [ stream nextPut: localIndex ] ] ].
	listElement selectionModel unhideIndexes: visibleIdxes
]

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ {
		  ToSieveSelectionChangedEvent.
		  ToCollectionFilteredEvent }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	anEvent currentTarget dataSource notifyChanged.
	select hideSelected ifTrue: [
		listElement selectionModel unhideAll.
		listElement dataAccessor withIndexDo: [ :d :localIndex |
			| originalIndex |
			originalIndex := select sieve dataPositionIndex at: d.
			(listElement selectionModel containsIndex: localIndex) ifTrue: [
				listElement selectionModel hideIndex: localIndex.
				select selectionModel hideIndex: originalIndex ] ] ].
	select notifySelectionChanged
]
