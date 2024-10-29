Class {
	#name : #ToElementWithContextMenuEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'event handling' }
ToElementWithContextMenuEventHandler >> contextMenuClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithContextMenuEventHandler >> contextMenuOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]
