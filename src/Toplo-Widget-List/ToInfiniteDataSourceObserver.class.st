Class {
	#name : #ToInfiniteDataSourceObserver,
	#superclass : #BlInfiniteElementDataSourceObserver,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	super infiniteDataSourceChanged: anEvent.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [	

	super infiniteDataSourceItemRangeChanged: anEvent	.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	super infiniteDataSourceItemRangeEvent: anEvent.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	super infiniteDataSourceItemRangeInserted: anEvent.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [ 

	super infiniteDataSourceItemRangeRemoved: anEvent.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.

	self triggerUpdateProcessor.
	infiniteElement listElement dispatchEvent: anEvent copy
]
