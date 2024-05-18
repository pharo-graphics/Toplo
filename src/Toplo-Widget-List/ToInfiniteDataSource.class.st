Class {
	#name : #ToInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToInfiniteDataSource >> dataAccessor [

	^ self subclassResponsibility 
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
