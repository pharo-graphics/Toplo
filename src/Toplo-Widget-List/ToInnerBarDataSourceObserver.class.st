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

	innerBarElement dataSourceManager onItemsChanged.
	innerBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [

	innerBarElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy

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
	innerBarElement listElement dispatchEvent: anEvent copy

]

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [

	innerBarElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.
	innerBarElement listElement dispatchEvent: anEvent copy

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

{ #category : #'event handling' }
ToInnerBarDataSourceObserver >> selecterCommandApplicationRequest: aCommandApplicationRequest [

	| command selecter |
	command := aCommandApplicationRequest command.
	selecter := aCommandApplicationRequest selecter.
	selecter applyCommand: command
]
