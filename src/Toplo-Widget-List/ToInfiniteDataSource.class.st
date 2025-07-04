Class {
	#name : #ToInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #accessing }
ToInfiniteDataSource >> dataAccessor [

	^ self subclassResponsibility 
]

{ #category : #notifications }
ToInfiniteDataSource >> notifyChangedAllDataItems: aDataItemArray [

	self subclassResponsibility 
]

{ #category : #notifications }
ToInfiniteDataSource >> notifyChangedDataItem: aDataItem [

	self subclassResponsibility 
]

{ #category : #notifications }
ToInfiniteDataSource >> notifyDataItemChangeIndex: anInteger [
	
	self notifyDataItemChangeInterval: (anInteger to: anInteger)
]

{ #category : #notifications }
ToInfiniteDataSource >> notifyDataItemChangeIndexes: anIntegerArray [

	anIntegerArray do: [ :idx | self notifyDataItemChangeIndex: idx ]
]

{ #category : #notifications }
ToInfiniteDataSource >> notifyDataItemChangeInterval: anInterval [
	
	self notifyItemsChanged: anInterval
]

{ #category : #'event firing' }
ToInfiniteDataSource >> notifyItemsFiltered [
	"Notify any registered observers that data source have been newly filtered.
	This is a structural change event"

	self notifyWithEvent: (ToInfiniteDataSourceItemsFiltered
			 position: 1
			 itemCount: self itemCount)
]

{ #category : #'event firing' }
ToInfiniteDataSource >> notifyItemsSievedWith: aSieve [
	"Notify any registered observers that data source have been newly filtered.
	This is a structural change event"

	self notifyWithEvent: (ToInfiniteDataSourceItemsSieved
		position: 1
		itemCount: self itemCount
		sieve: aSieve )
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]
