Class {
	#name : #ToWidgetWithContextMenuEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'mouseButton'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'element handlers' }
ToWidgetWithContextMenuEventHandler >> elementPositionChangedEvent: anEvent [
self flag: 'To be tracked'.
	"anEvent currentTarget close"

]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> eventsToHandle [
	self flag: 'check why BlElementPositionChangedEvent'.
	^ { 
		  "BlElementPositionChangedEvent."
		  BlMouseDownEvent }
]

{ #category : #private }
ToWidgetWithContextMenuEventHandler >> hideContextMenuFor: aWidget [

	aWidget contextMenu ifNotNil: [ :m | m close ]
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

	| win |
	aWidget contextMenu ifNil: [ ^ self ].
	win := aWidget contextMenu.
	win isAttachedToSceneGraph ifTrue: [ ^ self ].
	win popupEvent: anEvent
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
