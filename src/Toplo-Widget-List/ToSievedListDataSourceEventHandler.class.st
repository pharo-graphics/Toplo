Class {
	#name : #ToSievedListDataSourceEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'listElement',
		'sieveSelectionModel',
		'originalIndexMap'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'data source events handling' }
ToSievedListDataSourceEventHandler >> buildOriginalIndexMap [

	originalIndexMap removeAll.
	sieveSelectionModel deselectAll.
	listElement postponeAction: [
		listElement dataSource withIndexDo: [ :aData :idx |
			originalIndexMap at: aData put: idx ].
		sieveSelectionModel copySelectionFrom: listElement selectionModel ]
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
ToSievedListDataSourceEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	sieveSelectionModel := sieve selectionModel.
	self originalIndexMap: sieve originalIndexMap.
	self buildOriginalIndexMap
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> originalIndexMap: aDictionary [

	originalIndexMap := aDictionary
]

{ #category : #accessing }
ToSievedListDataSourceEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
