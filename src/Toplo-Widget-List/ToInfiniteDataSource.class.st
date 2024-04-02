Class {
	#name : #ToInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'infiniteElementSharedHandler'
	],
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

{ #category : #hooks }
ToInfiniteDataSource >> onAttached: anInfiniteElement [

	super onAttached: anInfiniteElement.

	infiniteElementSharedHandler := BlSharedEventDistributor new
		                     shareEvents: self sharedEvents;
		                     yourself.
	self addEventHandler: infiniteElementSharedHandler.
	anInfiniteElement addEventHandler: infiniteElementSharedHandler.

	self notifyChanged
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]

{ #category : #hooks }
ToInfiniteDataSource >> onDetached: anInfiniteElement [

	self removeEventHandler: infiniteElementSharedHandler.
	anInfiniteElement removeEventHandler: infiniteElementSharedHandler.
	infiniteElementSharedHandler := nil.
	super onDetached: anInfiniteElement.


	
]

{ #category : #hooks }
ToInfiniteDataSource >> sharedEvents [

	^ {
		  BlInfiniteDataSourceEvent }
]
