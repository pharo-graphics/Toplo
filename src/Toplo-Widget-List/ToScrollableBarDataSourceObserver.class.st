Class {
	#name : #ToScrollableBarDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerLinearBarElement'
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

	innerLinearBarElement dataSourceManager onItemsChanged.
	innerLinearBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerLinearBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement parentBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [ :anIndex |
		| anElementHolder |
		anElementHolder := (innerLinearBarElement findElementHolderForDataSourcePosition: anIndex).
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerLinearBarElement parentBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerLinearBarElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerLinearBarElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement parentBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	innerLinearBarElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement parentBarElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToScrollableBarDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	
	innerLinearBarElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerLinearBarElement parentBarElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToScrollableBarDataSourceObserver >> initializeWith: anInnerLinearBarElement [
	
	self
		assert: [ innerLinearBarElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerLinearBarElement := anInnerLinearBarElement
]
