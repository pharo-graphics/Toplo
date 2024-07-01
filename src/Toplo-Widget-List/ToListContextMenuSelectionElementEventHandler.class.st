Class {
	#name : #ToListContextMenuSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> contextMenuClosedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target enableScrolledEvent.
	target contextMenuSelecter deselectAll
]

{ #category : #'selection managing' }
ToListContextMenuSelectionElementEventHandler >> differUpdateSelectionFrom: anElement [
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

	" find de node at the event position "
	childNode := nodeContainer nodes
		             detect: [ :node |
			             node holder isSelectable and: [
				             node containsGlobalPoint: globalPosition ] ]
		             ifNone: [  ].

	" if no child is found -> just deselect all "
	selectionModel := target newPrimarySelectionModel.
	" pass the selection model to the event for the context menu window builder.
	see ToAnchoredWindowManager>>newWindowEvent: "
	anEvent selectionModel: selectionModel.
	childNode
		ifNil: [ target contextMenuSelecter deselectAll ]
		ifNotNil: [
			childNode holder isSelected
				ifTrue: [ " the detected node is selected -> 
					the context menu is over all selected nodes"
					selectionModel copySelectionFrom: target selectionModel.
					target contextMenuSelecter selectIndexes:
						selectionModel selectedIndexes.
					anEvent selectionModel: target selectionModel]
				ifFalse: [ " the detected node is not selected -> 
					the context menu is only over the detected node "
					selectionModel selectIndex: childNode holder position.
					target contextMenuSelecter selectIndex: childNode holder position.
					 ] ]
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [
	" the context menu should be close "

	| target |
	target := anEvent currentTarget.
	target currentContextMenu ifNotNil: [ :win |
		win isOpened ifTrue: [ win close ] ]
]
