Class {
	#name : #ToListElementContextMenuManager,
	#superclass : #ToContextMenuManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToListElementContextMenuManager >> newWindowRequestFrom: anEvent [
	" as an example from the ToElementContextMenuEventHandler>>mouseDownEvent: "

	|  selectionModel |
	" copy the selection to have unabled, hidden and unselectable selection passed to the menu builder "
	selectionModel := anEvent currentTarget selectionModel copy.
	" pass the selection model to the event for the context menu window builder.
	see ToAnchoredWindowManager>>newWindowEvent: "

	^ (super newWindowRequestFrom: anEvent)
		  selectionModel: selectionModel;
		  yourself
]

{ #category : #'window handling' }
ToListElementContextMenuManager >> onClosed [

	element contextMenuSelecter deselectAll.
	super onClosed.

]

{ #category : #accessing }
ToListElementContextMenuManager >> windowRequestClass [

	^ ToListElementContextMenuRequest
]
