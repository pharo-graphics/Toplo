Class {
	#name : #ToInnerFiniteListDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'instance creation' }
ToInnerFiniteListDataSourceObserver class >> on: anInnerLinearBarElement [
	^ self new
		initializeWith: anInnerLinearBarElement;
		yourself
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	innerBarElement dataSourceManager onItemsChanged
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [
		:anIndex |
		| anElementHolder |
		anElementHolder := innerBarElement
			                   findElementHolderForDataSourcePosition: anIndex.
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerBarElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

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
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	innerBarElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInnerFiniteListDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	
	innerBarElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToInnerFiniteListDataSourceObserver >> initializeWith: anInnerLinearBarElement [
	
	self
		assert: [ innerBarElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerBarElement := anInnerLinearBarElement
]
