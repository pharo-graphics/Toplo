Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'widgetWithContextMenuEventHandler',
		'widgetExtentChangeHandler',
		'widgetScrollHandler'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'parent menu' }
ToContextMenu >> allParentMenusDo: aBlock [
]

{ #category : #'t - menu window model - window opening/closing' }
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

{ #category : #testing }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #'t - menu window model - accessing' }
ToContextMenu >> menuWindow [

	^ self 
]

{ #category : #'t - menu window model - window opening/closing' }
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
