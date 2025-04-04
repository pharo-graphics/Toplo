Class {
	#name : #ToInnerBarDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToInnerBarDataSourceObserver class >> on: anInnerLinearBarElement [
	^ self new
		initializeWith: anInnerLinearBarElement;
		yourself
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	innerBarElement dataSourceManager onItemsChanged
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [
		:anIndex |
		| anElementHolder |
		anElementHolder := innerBarElement
			                   findElementHolderForDataSourcePosition: anIndex.
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerBarElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerBarElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.
	" update the secondary selection because it can be on the removed nodes "
	innerBarElement listElement secondarySelecter
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1.
	innerBarElement listElement selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	innerBarElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	
	innerBarElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerBarElement listElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToInnerBarDataSourceObserver >> initializeWith: anInnerLinearBarElement [
	
	self
		assert: [ innerBarElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerBarElement := anInnerLinearBarElement
]
