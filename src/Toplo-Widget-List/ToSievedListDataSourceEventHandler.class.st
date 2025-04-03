Class {
	#name : #ToSievedListDataSourceEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'dataPositionIndex',
		'sieveSelectionModel'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> buildOriginalIndexMapFrom: aListElement [


	dataPositionIndex removeAll.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #'api - accessing' }
ToSievedListDataSourceEventHandler >> eventsToHandle [

	^ {
		  BlInfiniteDataSourceChanged.
		  BlInfiniteDataSourceItemRangeChanged.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved }
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMapFrom: anEvent currentTarget
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceItemRangeChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMapFrom: anEvent currentTarget
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMapFrom: anEvent currentTarget
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceItemRangeRemoved: anEvent [

	" no need to update dataPositionIndex here "
]

{ #category : #'api - hooks' }
ToSievedListDataSourceEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	sieveSelectionModel := sieve selectionModel.
	self originalIndexMap: sieve originalIndexMap.
	self buildOriginalIndexMapFrom: aListElement
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> originalIndexMap: aDictionary [

	dataPositionIndex := aDictionary
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
