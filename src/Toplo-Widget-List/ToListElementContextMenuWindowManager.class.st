Class {
	#name : #ToListElementContextMenuWindowManager,
	#superclass : #ToContextMenuWindowManager,
	#category : #'Toplo-Widget-List-Context-menu'
}

{ #category : #'element handlers' }
ToListElementContextMenuWindowManager >> listContextMenuClosedEvent: anEvent [

	self contextMenuClosedEvent: anEvent
]

{ #category : #'element handlers' }
ToListElementContextMenuWindowManager >> listContextMenuOpenedEvent: anEvent [

	self contextMenuOpenedEvent: anEvent
]

{ #category : #'element handlers' }
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

{ #category : #'window handling' }
ToListElementContextMenuWindowManager >> onWindowClosed [

	super onWindowClosed.
	element enableScrolledEvent.
	element contextMenuSelecter deselectAll

]

{ #category : #'window handling' }
ToListElementContextMenuWindowManager >> onWindowOpened [ 

	super onWindowOpened.
	element disableScrolledEvent.


]

{ #category : #accessing }
ToListElementContextMenuWindowManager >> windowClosedEventClass [ 

	^ ToListContextMenuClosedEvent  
]

{ #category : #accessing }
ToListElementContextMenuWindowManager >> windowOpenRequestClass [

	^ ToListElementContextMenuRequest
]

{ #category : #accessing }
ToListElementContextMenuWindowManager >> windowOpenedEventClass [ 

	^ ToListContextMenuOpenedEvent  
]
