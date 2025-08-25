Class {
	#name : #ToListElementContextMenuManager,
	#superclass : #ToContextMenuManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToListElementContextMenuManager >> newWindowRequestOnEvent: anEvent [
	" as an example, sent from my mouseDownEvent: "

	|  selectionModel |
	" copy the selection to have unabled, hidden and unselectable selection passed to the menu builder "
	selectionModel := anEvent currentTarget selectionModel copy.
	" pass the selection model to the event for the context menu window builder.
	see ToAnchoredWindowManager>>newWindowEvent: "

	^ (super newWindowRequestOnEvent: anEvent)
		  selectionModel: selectionModel;
		  yourself
]

{ #category : #'window handling' }
ToListElementContextMenuManager >> onWindowClosed [

	anchorElement contextMenuSelecter deselectAll.
	super onWindowClosed.

]

{ #category : #accessing }
ToListElementContextMenuManager >> windowRequestClass [

	^ ToListElementContextMenuRequest
]
