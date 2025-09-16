Class {
	#name : #ToListElementContextMenuManager,
	#superclass : #ToContextMenuManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToListElementContextMenuManager >> newWindowRequestOnEvent: anEvent [
	" feed the request with a copy of the selectionModel to be used from the window builder valuable "

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
ToListElementContextMenuManager >> onWindowClosedOnEvent: anEvent [

	anchorElement contextMenuSelecter deselectAll.
	super onWindowClosedOnEvent: anEvent

]

{ #category : #accessing }
ToListElementContextMenuManager >> windowRequestClass [

	^ ToListElementContextMenuRequest
]
