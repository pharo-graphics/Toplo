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

	| listElement hidden |
	listElement := select listElement.
	select isMultipleSelection ifFalse: [
		listElement secondarySelectionModel deselectAll ].

	(select isMultipleSelection and: [ select hideSelected ]) ifFalse: [
		^ self ].
	hidden := Array streamContents: [:stream | 
		select dataAccessor withIndexDo: [ :d :idx |
		(listElement selectionModel containsIndex: idx)
			ifTrue: [ stream nextPut: idx ]] ].
	listElement hiddenSelectionModel deselectAll; selectIndexes: hidden
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

	anEvent currentTarget dataSource notifyChanged.
	select copySelectionFrom: anEvent selectionModel.
	
]
