Class {
	#name : #ToWidgetWithContextMenuEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'mouseButton',
		'contextMenu'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> eventsToHandle [

	^ { BlMouseDownEvent }
]

{ #category : #private }
ToWidgetWithContextMenuEventHandler >> hideContextMenuFor: aWidget [

	contextMenu ifNotNil: [ :m |
		m close.
		contextMenu := nil ]
]

{ #category : #initialization }
ToWidgetWithContextMenuEventHandler >> initialize [

	super initialize.
	self useSecondaryMouseButton 
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> mouseDownEvent: anEvent [

	anEvent button = mouseButton ifFalse: [ ^ self ].
	self hideContextMenuFor: anEvent currentTarget.
	self
		popupContextMenuFor: anEvent currentTarget 
		event: anEvent
]

{ #category : #private }
ToWidgetWithContextMenuEventHandler >> popupContextMenuFor: aWidget event: anEvent [

	aWidget dispatchEvent: (ToContextMenuOpenedEvent new
			 widget: aWidget;
			 sourceEvent: anEvent;
			 yourself).
	contextMenu := aWidget contextMenu.
	contextMenu popupEvent: anEvent
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
