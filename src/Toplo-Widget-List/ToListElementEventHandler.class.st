Class {
	#name : #ToListElementEventHandler,
	#superclass : #ToForwardedEventHandler,
	#category : #'Toplo-Widget-List-core'
}

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> blurEvent: anEvent [

	anEvent currentTarget blurEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionAddEvent: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter collectionAddEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionAddRequest: anEvent [


]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionFilterEvent: anEvent [


]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionFilterRequest: anEvent [


]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionRemoveEvent: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter collectionRemoveEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionRemoveRequest: anEvent [


]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionUpdateEvent: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter collectionUpdateEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionUpdateRequest: anEvent [

]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target removeSecondarySelectionDecoration.
	target secondarySelection deselectAll.
	target infinite enableScrolledEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> contextMenuOpenedEvent: anEvent [

	| pos targetChildren childNode target infinite |
	target := anEvent currentTarget.
	infinite := target infinite.
	infinite disableScrolledEvent.
	pos := infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	childNode := targetChildren last.
	childNode holder isSelected
		ifTrue: [ 
			target secondarySelectionOverPrimary.		
			target secondarySelection selectIndexes: target primarySelectionIndexes. ]
		ifFalse: [
			target addSecondarySelectionDecorationOnNode: childNode.
			target secondarySelection selectIndex: childNode holder position]
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> dataFilterRequest: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter dataFilterRequest: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> dataFilterResultEvent: anEvent [
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> elementExtentChangedEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ { 
		  ToDataFilterRequest.
		  ToDataFilterResultEvent.

		  " data (ToObservableCollection) events "
		  ToCollectionAddEvent.
		  ToCollectionFilterEvent.
		  ToCollectionRemoveEvent.
		  ToCollectionUpdateEvent.
		  ToCollectionAddRequest.
		  ToCollectionFilterRequest.
		  ToCollectionRemoveRequest.
		  ToCollectionUpdateRequest.

		  " data source events "
		  BlInfiniteDataSourceChanged.
		  BlInfiniteDataSourceItemRangeChanged.
		  BlInfiniteDataSourceItemRangeEvent.
		  BlInfiniteDataSourceItemRangeRemoved.
		  BlInfiniteDataSourceItemRangeInserted.
		  ToDataEmptinessChangeEvent.


		  " infinite element events "
		  ToListStrongSelectionEvent.
		  BlElementScrolledEvent.
		  BlElementExtentChangedEvent.
		  ToInfiniteSelectionChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  ToContextMenuOpenedEvent.
		  ToContextMenuClosedEvent }
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> focusEvent: anEvent [

	anEvent currentTarget focusEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> infiniteSelectionChangedEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> listDataEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target data ifEmpty: [ ^ target showPlaceholder ].
	target hidePlaceholder
]

{ #category : #'data source events handling' }
ToListElementEventHandler >> onChanged: anEvent [
	" anEvent is a BlInfiniteDataSourceChanged "

]

{ #category : #'data source events handling' }
ToListElementEventHandler >> onItemsChanged: anEvent [
	" anEvent is a BlInfiniteDataSourceItemRangeChanged "

]

{ #category : #'data source events handling' }
ToListElementEventHandler >> onItemsEvent: anEvent [
	" anEvent is a BlInfiniteDataSourceItemRangeEvent "

]

{ #category : #'data source events handling' }
ToListElementEventHandler >> onItemsInserted: anEvent [

	" anEvent is a BlInfiniteDataSourceItemRangeInserted "

]

{ #category : #'data source events handling' }
ToListElementEventHandler >> onItemsRemoved: anEvent [
	" anEvent is a BlInfiniteDataSourceItemRangeRemoved "


]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> strongSelectionEvent: anEvent [
]
