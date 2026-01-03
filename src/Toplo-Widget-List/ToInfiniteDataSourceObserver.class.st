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
	listElement requestUpdateAllSelections
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	| listElement |
	super infiniteDataSourceItemRangeChanged: anEvent.
	listElement := infiniteElement listElement.
	listElement requestUpdateAllSelections
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	| listElement |
	super infiniteDataSourceItemRangeInserted: anEvent.
	listElement := infiniteElement listElement.
	listElement selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	| listElement |
	super infiniteDataSourceItemRangeRemoved: anEvent.

	" update the secondary selection because it can be on the removed nodes "
	listElement := infiniteElement listElement.
	listElement secondarySelecter
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1.
	listElement selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.

	self triggerUpdateProcessor
]
