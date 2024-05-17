Extension { #name : #ToInfiniteDataSourceObserver }

{ #category : #'*Toplo-Widget-List' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor.
	infiniteElement listElement dispatchEvent: anEvent copy
]

{ #category : #'*Toplo-Widget-List' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.

	self triggerUpdateProcessor.
	infiniteElement listElement dispatchEvent: anEvent copy
]
