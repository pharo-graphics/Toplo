Class {
	#name : #ToListElementContextMenuWindowManager,
	#superclass : #ToContextMenuWindowManager,
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #'event handling' }
ToListElementContextMenuWindowManager >> listElementContextMenuRequest: anEvent [

	self contextMenuRequest: anEvent
]

{ #category : #'window handling' }
ToListElementContextMenuWindowManager >> newWindowOpenRequestEventFromSourceEvent: anEvent [
	" request from the ToElementContextMenuEventHandler>>mouseDownEvent: "

	| target selectionModel |
	target := anEvent currentTarget.
	" copy the selection to have unabled, hidden and unselectable selection passed to the menu builder "
	selectionModel := target selectionModel copy.
	" pass the selection model to the event for the context menu window builder.
	see ToAnchoredWindowManager>>newWindowEvent: "

	^ (super newWindowOpenRequestEventFromSourceEvent: anEvent)
		  sourceEvent: anEvent;
		  selectionModel: selectionModel;
		  yourself
]

{ #category : #'event handling' }
ToListElementContextMenuWindowManager >> popupWindowClosedEvent: anEvent [

	super popupWindowClosedEvent: anEvent.
	element contextMenuSelecter deselectAll
]

{ #category : #accessing }
ToListElementContextMenuWindowManager >> windowOpenRequestClass [

	^ ToListElementContextMenuRequest
]
