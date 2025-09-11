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
	listElement postponeAction: [ :l |
		l dataSource withIndexDo: [ :aData :idx |
			sieve originalIndexMap at: aData put: idx ].
		sieve selectionModel copySelectionFrom: l selectionModel ]
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

{ #category : #'api - hooks' }
ToSievedListDataSourceEventHandler >> onInstalledIn: aDataSource [

	super onInstalledIn: aDataSource.
	self buildOriginalIndexMap 
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
