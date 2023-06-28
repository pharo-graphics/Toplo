Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder',
	#classTraits : 'TToMenuItemHolder classTrait',
	#instVars : [
		'widgetWithContextMenuEventHandler',
		'widgetExtentChangeHandler',
		'widgetScrollHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - menu window accessing' }
ToContextMenu >> allParentMenusDo: aBlock [
]

{ #category : #'initialize-release' }
ToContextMenu >> close [

	self isOpened ifFalse: [ ^ self ].
	super close.
	self widget dispatchEvent: (ToContextMenuClosedEvent new
			 widget: self widget;
			 yourself)
]

{ #category : #initialization }
ToContextMenu >> defaulPositioningHook [

	^ [ :w :event | event position ]
]

{ #category : #'t - initialization dresser' }
ToContextMenu >> defaultDresser [ 

	^ ToContextMenuDresser new
]

{ #category : #initialization }
ToContextMenu >> initialize [

	super initialize.
	self initializeMenuItemHolder.

]

{ #category : #initialization }
ToContextMenu >> installedInWidget: aWidget [

	widgetExtentChangeHandler := BlEventHandler
		                       on: BlElementExtentChangedEvent
		                       do: [ :evt | self close ].

	widgetScrollHandler := BlEventHandler
		                 on: BlElementScrolledEvent
		                 do: [ :evt | self close ].

	aWidget addEventHandler: widgetExtentChangeHandler.
	aWidget addEventHandler: widgetScrollHandler.

]

{ #category : #'t - menu window accessing' }
ToContextMenu >> menuWindow [ 

	^ self
]

{ #category : #'api - displaying' }
ToContextMenu >> popupEvent: anEvent [

	self widget ifNotNil: [ :w | w openedContextMenu: self ].
	self requestFocus.
	super popupEvent: anEvent
]

{ #category : #initialization }
ToContextMenu >> uninstalledFromWidget: aWidget [

	aWidget ifNil: [ ^ self ].
	aWidget removeEventHandler: widgetExtentChangeHandler.
	widgetExtentChangeHandler := nil.
	aWidget removeEventHandler: widgetScrollHandler.
	widgetScrollHandler := nil

]
