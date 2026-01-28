Class {
	#name : #ToInnerFiniteListDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerListElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'instance creation' }
ToInnerFiniteListDataSourceObserver class >> on: anInnerLinearBarElement [
	^ self new
		initializeWith: anInnerLinearBarElement;
		yourself
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	innerListElement dataSourceManager onItemsChanged
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerListElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [
		:anIndex |
		| anElementHolder |
		anElementHolder := innerListElement
			                   findElementHolderForDataSourcePosition: anIndex.
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerListElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerListElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerListElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemsFilteredEvent: anEvent [

	innerListElement dataSourceManager onItemsChanged.
	innerListElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerListElement listElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToInnerFiniteListDataSourceObserver >> initializeWith: anInnerListElement [
	
	self
		assert: [ innerListElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerListElement := anInnerListElement
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> listDataSourceItemsSievedEvent: anEvent [

	innerListElement dataSourceManager onItemsChanged.
	innerListElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerListElement listElement dispatchEvent: anEvent copy
]
