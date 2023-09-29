Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - accessing' }
ToListElementEventHandler >> blurEvent: anEvent [

	anEvent currentTarget blurEvent: anEvent
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target removeSecondarySelectionDecoration.
	target secondarySelection deselectAll.
	target infinite enableScrolledEvent
]

{ #category : #'api - accessing' }
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

{ #category : #'api - accessing' }
ToListElementEventHandler >> elementExtentChangedEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {
		  BlElementScrolledEvent.
		  BlElementExtentChangedEvent.
		  ToInfiniteSelectionChangedEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  ToContextMenuOpenedEvent.
		ToContextMenuClosedEvent }
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> focusEvent: anEvent [

	anEvent currentTarget focusEvent: anEvent
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> infiniteSelectionChangedEvent: anEvent [

	anEvent currentTarget updatePrimarySelectionDecorations
]
