Class {
	#name : 'ToElementWithContextMenuEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'mouseButton',
		'contextMenu'
	],
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'api - accessing' }
ToElementWithContextMenuEventHandler >> eventsToHandle [
	^ { BlMouseDownEvent }
]

{ #category : 'initialization' }
ToElementWithContextMenuEventHandler >> initialize [

	super initialize.
	self useSecondaryMouseButton 
]

{ #category : 'api - accessing' }
ToElementWithContextMenuEventHandler >> mouseDownEvent: anEvent [

	anEvent button = mouseButton ifFalse: [ ^ self ].
	self
		popupContextMenuFor: anEvent currentTarget 
		event: anEvent
]

{ #category : 'private' }
ToElementWithContextMenuEventHandler >> popupContextMenuFor: anElement event: anEvent [

	contextMenu := anElement currentContextMenu.
	contextMenu popupEvent: anEvent
]

{ #category : 'api - accessing' }
ToElementWithContextMenuEventHandler >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : 'api - accessing' }
ToElementWithContextMenuEventHandler >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
