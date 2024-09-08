Class {
	#name : #ToListContextMenuSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#traits : 'TToListElementEventHandler',
	#classTraits : 'TToListElementEventHandler classTrait',
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target enableScrolledEvent.
	target contextMenuSelecter deselectAll
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> elementScrolledEvent: anEvent [
]

{ #category : #'api - accessing' }
ToListContextMenuSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListPrimarySelectionChangedEvent.
		  ToListElementContextMenuRequest.
		  ToContextMenuClosedEvent.
		  ToListContextMenuSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> listContextMenuSelectionChangedEvent: anEvent [
	" sent by the context menu selecter"

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> listElementContextMenuRequest: anEvent [

	| childNode target nodeContainer globalPosition selectionModel |
	target := anEvent currentTarget.
	nodeContainer := target innerContainer.
	target disableScrolledEvent.
	globalPosition := anEvent sourceEvent position.

	target isWithContextMenuSelection ifFalse: [ ^ self ].

	" find de node at the event position "
	self
		withTargetNodeFromEvent: anEvent sourceEvent
		do: [ :node | childNode := node ].

	selectionModel := anEvent selectionModel.
	childNode
		ifNil: [ " no found node -> just deselectAll "
			selectionModel deselectAll.
			target contextMenuSelecter deselectAll ]
		ifNotNil: [
			childNode holder isSelected
				ifTrue: [ " the detected node is selected -> 
					the context menu is over all selected nodes"
					target contextMenuSelecter selectIndexes:
						selectionModel selectedIndexes.
					anEvent selectionModel: selectionModel ]
				ifFalse: [ " the detected node is not selected -> 
					the context menu is only over the detected node "
					selectionModel
						deselectAll;
						selectIndex: childNode holder position.
					target contextMenuSelecter selectOnlyIndex:
						childNode holder position ] ]
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [
	" the context menu should be close "

	| target |
	target := anEvent currentTarget.
	target currentContextMenu ifNotNil: [ :win |
		win isOpened ifTrue: [ win close ] ]
]
