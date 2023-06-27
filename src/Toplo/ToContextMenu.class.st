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

	super close.
	self widget dispatchEvent: (ToContextMenuClosedEvent new
			 widget: self widget;
			 yourself).
	self widget ifNotNil: [ :w | self widget requestFocus ]
]

{ #category : #initialization }
ToContextMenu >> defaultHook [

	^ [ :w :event | event position ]
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

{ #category : #'api - displaying' }
ToContextMenu >> popupEvent: anEvent [

	self widget ifNotNil: [ :w | w lastOpenedContextMenu: self ].
	self requestFocus.
	super popupEvent: anEvent
]

{ #category : #'t - menu window accessing' }
ToContextMenu >> subMenuWindow [ 

	^ self
]

{ #category : #initialization }
ToContextMenu >> uninstalledFromWidget: aWidget [

	aWidget ifNil: [ ^ self ].
	aWidget removeEventHandler: widgetExtentChangeHandler.
	widgetExtentChangeHandler := nil.
	aWidget removeEventHandler: widgetScrollHandler.
	widgetScrollHandler := nil

]
