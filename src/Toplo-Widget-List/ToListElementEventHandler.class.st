Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : 'Toplo-Widget-List-core'
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
ToListElementEventHandler >> collectionRemoveEvent: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter collectionRemoveEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> collectionUpdateEvent: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter collectionUpdateEvent: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> contextMenuBeforeBuildingEvent: anEvent [

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
			target secondarySelection selectIndexes: target primarySelectionIndexes ]
		ifFalse: [
			target addSecondarySelectionDecorationOnNode: childNode.
			target secondarySelection selectIndex: childNode holder position ]
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
ToListElementEventHandler >> dataEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target data ifEmpty: [ ^ target showPlaceholder ].
	target hidePlaceholder
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> dataFilterRequest: anEvent [

	anEvent currentTarget dataFilter ifNil: [ ^ self ].
	anEvent currentTarget dataFilter dataFilterRequest: anEvent
]

{ #category : #'infinite element events handling' }
ToListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target data ifEmpty: [ ^ target showPlaceholder ].
	target hidePlaceholder
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
		  BlElementAddedToSceneGraphEvent.

		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.

		  " data (ToObservableCollection) events "
		  ToCollectionAddEvent.
		  ToCollectionRemoveEvent.
		  ToCollectionUpdateEvent.

		  " data source events "
		  ToDataEmptinessChangeEvent.
		  ToDataFilterRequest.

		  " infinite element events "
		  ToInfiniteSelectionChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  ToContextMenuBeforeBuildingEvent.
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
