Class {
	#name : #ToFiniteListDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerBarElement'
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

	innerBarElement dataSourceManager onItemsChanged
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [
		:anIndex |
		| anElementHolder |
		anElementHolder := innerBarElement
			                   findElementHolderForDataSourcePosition: anIndex.
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerBarElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerBarElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.
	" update the secondary selection because it can be on the removed nodes "
	innerBarElement listElement secondarySelecter
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1.
	innerBarElement listElement selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position.
	"innerBarElement spaceDo: [ :sp |
		sp enqueueTask:
			(BlTaskAction new action: [ sp mouseProcessor handleLastMouseMove ]) ]"
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> infiniteDataSourceItemsFilteredEvent: anEvent [

	innerBarElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToFiniteListDataSourceObserver >> initializeWith: anInnerLinearBarElement [
	
	self
		assert: [ innerBarElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerBarElement := anInnerLinearBarElement
]

{ #category : #'event handling' }
ToFiniteListDataSourceObserver >> listDataSourceItemsSievedEvent: anEvent [
	
	innerBarElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerBarElement listElement dispatchEvent: anEvent copy
]
