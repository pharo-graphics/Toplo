Class {
	#name : #ToSievedListDataSourceEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'listElement'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> buildOriginalIndexMap [

	sieve originalIndexMap removeAll.
	sieve selectionModel deselectAll.
	listElement postponeAction: [
		listElement dataSource withIndexDo: [ :aData :idx |
			sieve originalIndexMap at: aData put: idx ].
		sieve selectionModel copySelectionFrom: listElement selectionModel ]
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
	self buildOriginalIndexMap
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceItemRangeChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMap
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMap
]

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> infiniteDataSourceItemRangeRemoved: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMap
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
