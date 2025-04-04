Class {
	#name : #ToInfiniteDataSourceObserver,
	#superclass : #BlInfiniteElementDataSourceObserver,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	| listElement |
	super infiniteDataSourceChanged: anEvent.
	listElement := infiniteElement listElement.
	listElement whenLayoutedDoOnce: [ listElement updateAllSelections ]
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [	

	super infiniteDataSourceItemRangeChanged: anEvent	
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	super infiniteDataSourceItemRangeInserted: anEvent.
	infiniteElement listElement selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	super infiniteDataSourceItemRangeRemoved: anEvent.

	" update the secondary selection because it can be on the removed nodes "
	infiniteElement listElement secondarySelecter
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1.
	infiniteElement listElement selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position
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
