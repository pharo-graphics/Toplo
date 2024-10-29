Class {
	#name : #ToListElementWithContextMenuEventHandler,
	#superclass : #ToElementWithContextMenuEventHandler,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'element handlers' }
ToListElementWithContextMenuEventHandler >> listElementContextMenuRequest: anEvent [

	self contextMenuRequest: anEvent
]

{ #category : #'api - accessing' }
ToListElementWithContextMenuEventHandler >> windowEventsToHandle [

	^ {
		  ToListElementContextMenuRequest.
		  ToContextMenuClosedEvent.
		  ToContextMenuOpenedEvent }
]
