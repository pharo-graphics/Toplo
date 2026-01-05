Class {
	#name : #ToListDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #notifications }
ToListDataSource >> notifyChangedAllDataItems: aDataItemArray [

	self subclassResponsibility 
]

{ #category : #notifications }
ToListDataSource >> notifyChangedDataItem: aDataItem [

	self subclassResponsibility 
]

{ #category : #notifications }
ToListDataSource >> notifyDataItemChangeIndex: anInteger [
	
	self notifyDataItemChangeInterval: (anInteger to: anInteger)
]

{ #category : #notifications }
ToListDataSource >> notifyDataItemChangeIndexes: anIntegerArray [

	anIntegerArray do: [ :idx | self notifyDataItemChangeIndex: idx ]
]

{ #category : #notifications }
ToListDataSource >> notifyDataItemChangeInterval: anInterval [
	
	self notifyItemsChanged: anInterval
]

{ #category : #'event firing' }
ToListDataSource >> notifyItemsFiltered [
	"Notify any registered observers that data source have been newly filtered.
	This is a structural change event"

	self notifyWithEvent: (ToListDataSourceItemsFilteredEvent
			 position: 1
			 itemCount: self itemCount)
]

{ #category : #'event firing' }
ToListDataSource >> notifyItemsSievedWith: aSieve [
	"Notify any registered observers that data source have been newly filtered.
	This is a structural change event"

	self notifyWithEvent: (ToListDataSourceItemsSievedEvent
		position: 1
		itemCount: self itemCount
		sieve: aSieve )
]

{ #category : #'instance creation' }
ToListDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]
