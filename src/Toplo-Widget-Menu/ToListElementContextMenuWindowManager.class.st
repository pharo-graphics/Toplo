Class {
	#name : #ToListElementContextMenuWindowManager,
	#superclass : #ToContextMenuWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'event handling' }
ToListElementContextMenuWindowManager >> closedEvent: anEvent [

	super closedEvent: anEvent.
	element contextMenuSelecter deselectAll
]

{ #category : #'window handling' }
ToListElementContextMenuWindowManager >> newWindowRequestFrom: anEvent [
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

{ #category : #accessing }
ToListElementContextMenuWindowManager >> windowRequestClass [

	^ ToListElementContextMenuRequest
]
