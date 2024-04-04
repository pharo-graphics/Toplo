Extension { #name : #BlInfiniteElementDataSourceObserver }

{ #category : #'*Toplo-Widget-List' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor
]

{ #category : #'*Toplo-Widget-List' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.

	self triggerUpdateProcessor
]
