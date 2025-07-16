Class {
	#name : #ToListContextMenuSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListContextMenuSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListPrimarySelectionChangedEvent.
		  ToListElementContextMenuRequest.
		  ToListContextMenuSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> listContextMenuSelectionChangedEvent: anEvent [
	" sent by the context menu selecter"

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [
	" the context menu should be close "

	| target |
	target := anEvent currentTarget.
	target currentContextMenu ifNotNil: [ :win |
		win isOpened ifTrue: [ win close ] ]
]

{ #category : #'element handlers' }
ToListContextMenuSelectionElementEventHandler >> windowRequest: anEvent [

	| childNode target nodeContainer globalPosition selectionModel |
	target := anEvent currentTarget.
	nodeContainer := target innerElement.
	globalPosition := anEvent sourceEvent position.

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
ToListContextMenuSelectionElementEventHandler >> withTargetNodeFromEvent: anEvent do: aValuable [
	" crappy but useful to get the node from the position of the event.
	I'm used for selecting node and for context menu opening in case list node have margin"

	| globalPosition currTarget childNode |
	globalPosition := anEvent position.
	currTarget := anEvent currentTarget.
	childNode := currTarget nodes
		             detect: [ :node |
			             node holder isSelectable and: [
				             node containsGlobalPoint: globalPosition ] ]
		             ifNone: [
			             currTarget innerElement nodes
				             detect: [ :node |
					             | gap |
					             gap := currTarget isHorizontal
						                    ifTrue: [ node margin left ]
						                    ifFalse: [ node margin top ].
					             node holder isSelectable and: [
						             node containsGlobalPoint:
							             globalPosition - (0 @ gap) ] ]
				             ifNone: [
					             currTarget innerElement nodes
						             detect: [ :node |
							             | gap |
							             gap := currTarget isHorizontal
								                    ifTrue: [ node margin right ]
								                    ifFalse: [ node margin bottom ].
							             node holder isSelectable and: [
								             node containsGlobalPoint:
									             globalPosition + (0 @ gap) ] ]
						             ifNone: [  ] ] ].

	childNode ifNotNil: [ aValuable value: childNode ]
]
