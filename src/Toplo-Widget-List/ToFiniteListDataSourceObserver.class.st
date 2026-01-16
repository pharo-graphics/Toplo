Class {
	#name : #ToFiniteListDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerListElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'instance creation' }
ToFiniteListDataSourceObserver class >> on: anInnerLinearBarElement [
	^ self new
		initializeWith: anInnerLinearBarElement;
		yourself
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	innerListElement dataSourceManager onItemsChanged
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerListElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [
		:anIndex |
		| anElementHolder |
		anElementHolder := innerListElement
			                   findElementHolderForDataSourcePosition: anIndex.
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerListElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerListElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerListElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemsFilteredEvent: anEvent [

	innerListElement dataSourceManager onItemsChanged.
	innerListElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerListElement listElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToFiniteListDataSourceObserver >> initializeWith: anInnerListElement [
	
	self
		assert: [ innerListElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerListElement := anInnerListElement
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> listDataSourceItemsSievedEvent: anEvent [

	innerListElement dataSourceManager onItemsChanged.
	innerListElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerListElement listElement dispatchEvent: anEvent copy
]
