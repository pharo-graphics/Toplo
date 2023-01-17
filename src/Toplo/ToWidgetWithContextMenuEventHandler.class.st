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

	anEvent currentTarget close

]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> eventsToHandle [

	^ { 
		  BlElementPositionChangedEvent.
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
	"anEvent consumed: true."

	self hideContextMenuFor: anEvent currentTarget.
	self
		popupContextMenuFor: anEvent currentTarget 
		fromEventPosition: anEvent position
]

{ #category : #private }
ToWidgetWithContextMenuEventHandler >> popupContextMenuFor: aWidget fromEventPosition: aPosition [

	| ttPoint win |
	aWidget contextMenu ifNil: [ ^ self ].
	ttPoint := aPosition + self vgap.
	win := aWidget contextMenu menuWindow.
	win isAttachedToSceneGraph ifTrue: [ ^ self ].
	win popupAtGlobalPosition: ttPoint
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #'api - accessing' }
ToWidgetWithContextMenuEventHandler >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]

{ #category : #'showing / hiding' }
ToWidgetWithContextMenuEventHandler >> vgap [

	^ 0
]
