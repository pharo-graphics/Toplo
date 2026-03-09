Class {
	#name : #ToInfiniteDataSourceObserver,
	#superclass : #BlInfiniteElementDataSourceObserver,
	#category : #'Toplo-Widget-List'
}

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceChanged: anEvent [ 

	| listElement |
	super infiniteDataSourceChanged: anEvent.
	listElement := infiniteElement listElement.
	"listElement requestUpdateAllSelections"

]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	super infiniteDataSourceItemRangeChanged: anEvent
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	super infiniteDataSourceItemRangeInserted: anEvent
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	| listElement |

	super infiniteDataSourceItemRangeRemoved: anEvent.

	" update the secondary selection because it can be on the removed nodes "
	listElement := infiniteElement listElement.
	listElement secondarySelecter
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> infiniteDataSourceItemsFilteredEvent: anEvent [

	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.

	self triggerUpdateProcessor
]

{ #category : #'event handling' }
ToInfiniteDataSourceObserver >> listDataSourceItemsSievedEvent: anEvent [
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.

	self triggerUpdateProcessor
]
