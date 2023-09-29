Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-core'
}

{ #category : #'events - handling' }
ToListElementEventHandler >> blurEvent: anEvent [

	anEvent currentTarget blurEvent: anEvent
]

{ #category : #'events - handling' }
ToListElementEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target removeSecondarySelectionDecoration.
	target secondarySelection deselectAll.
	target infinite enableScrolledEvent
]

{ #category : #'events - handling' }
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

{ #category : #'events - handling' }
ToListElementEventHandler >> elementExtentChangedEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'events - handling' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {ToDataEmptinessChangeEvent.
		  ToListStrongSelectionEvent.
		  BlElementScrolledEvent.
		  BlElementExtentChangedEvent.
		  ToInfiniteSelectionChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  ToContextMenuOpenedEvent.
		  ToContextMenuClosedEvent }
]

{ #category : #'events - handling' }
ToListElementEventHandler >> focusEvent: anEvent [

	anEvent currentTarget focusEvent: anEvent
]

{ #category : #'api - event managing' }
ToListElementEventHandler >> handleEvent: anEvent [
	" The event can come from the infinite element. 
	In that case, the event is re-dispatched from here to allow client to simply 
	add handlers to my list element (and not have to ask to my infinite)"

	| evt |
	" if the event has been dispatched from here "
	anEvent source = anEvent currentTarget ifTrue: [
		^ super handleEvent: anEvent ].
	" if not, then clone the event and re-dispatch it from here"
	evt := anEvent clone.
	evt source: anEvent currentTarget.
	anEvent currentTarget dispatchEvent: evt
]

{ #category : #'events - handling' }
ToListElementEventHandler >> infiniteSelectionChangedEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'api - event managing' }
ToListElementEventHandler >> listDataEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target data ifEmpty: [ ^ target showPlaceholder ].
	target hidePlaceholder
]

{ #category : #'events - handling' }
ToListElementEventHandler >> strongSelectionEvent: anEvent [
]
