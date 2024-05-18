Class {
	#name : #ToInnerLinearBarDataSourceObserver,
	#superclass : #BlInfiniteDataSourceObserver,
	#instVars : [
		'innerLinearBarElement'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'instance creation' }
ToInnerLinearBarDataSourceObserver class >> on: anInnerLinearBarElement [
	^ self new
		initializeWith: anInnerLinearBarElement;
		yourself
]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceChanged: anEvent [

	innerLinearBarElement dataSourceManager onItemsChanged.
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerLinearBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [

	anEvent position to: anEvent position + anEvent itemCount - 1 do: [ :anIndex |
		| anElementHolder |
		anElementHolder := (innerLinearBarElement findElementHolderForDataSourcePosition: anIndex).
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ].
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [

	innerLinearBarElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerLinearBarElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceItemsFiltered: anEvent [

	innerLinearBarElement dataSourceManager
		onItemsFiltered: anEvent position
		itemCount: anEvent itemCount.
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy
]

{ #category : #'event handling' }
ToInnerLinearBarDataSourceObserver >> infiniteDataSourceItemsSieved: anEvent [
	
	innerLinearBarElement dataSourceManager
		onItemsSieved: anEvent position
		itemCount: anEvent itemCount
		with: anEvent sieve.
	innerLinearBarElement linearBarElement dispatchEvent: anEvent copy
]

{ #category : #initialization }
ToInnerLinearBarDataSourceObserver >> initializeWith: anInnerLinearBarElement [
	
	self
		assert: [ innerLinearBarElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	innerLinearBarElement := anInnerLinearBarElement
]
