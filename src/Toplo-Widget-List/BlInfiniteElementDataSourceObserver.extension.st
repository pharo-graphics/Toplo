Extension { #name : #BlInfiniteElementDataSourceObserver }

{ #category : #'*Toplo-Widget-List' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'*Toplo-Widget-List' }
BlInfiniteElementDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]
