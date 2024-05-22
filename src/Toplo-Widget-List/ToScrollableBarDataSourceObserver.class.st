Class {
	#name : #ToScrollableBarDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToScrollableBarDataSourceObserver class >> on: anInnerLinearBarElement [
	^ self new
		initializeWith: anInnerLinearBarElement;
		yourself
]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	innerBarElement dataSourceManager onItemsChanged.
	innerBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [ :anIndex |
		| anElementHolder |
		anElementHolder := (innerBarElement findElementHolderForDataSourcePosition: anIndex).
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerBarElement parentBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerBarElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerBarElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	innerBarElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement parentBarElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	
	innerBarElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerBarElement parentBarElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToScrollableBarDataSourceObserver >> initializeWith: anInnerLinearBarElement [
	
	self
		assert: [ innerBarElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerBarElement := anInnerLinearBarElement
]
