Class {
	#name : #ToListElementContextMenuWindowManager,
	#superclass : #ToContextMenuWindowManager,
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #'window handling' }
ToListElementContextMenuWindowManager >> newWindowOpenRequestEventFromSourceEvent: anEvent [
	" request from the ToElementContextMenuEventHandler>>mouseDownEvent: "

	| target selectionModel |
	target := anEvent currentTarget.
	" copy the selection to have unabled, hidden and unselectable selection passed to the menu builder "
	selectionModel := target selectionModel duplicate.
	" pass the selection model to the event for the context menu window builder.
	see ToAnchoredWindowManager>>newWindowEvent: "

	^ (super newWindowOpenRequestEventFromSourceEvent: anEvent)
		  sourceEvent: anEvent;
		  selectionModel: selectionModel;
		  yourself
]

{ #category : #accessing }
ToListElementContextMenuWindowManager >> windowOpenRequestClass [

	^ ToListElementContextMenuRequest
]
