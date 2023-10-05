Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'parent menu' }
ToContextMenu >> allParentMenusDo: aBlock [
]

{ #category : #'t - menu window model - window opening/closing' }
ToContextMenu >> close [

	self isOpened ifFalse: [ ^ self ].
	super close.
	self associateElement dispatchEvent: (ToContextMenuClosedEvent new
			 widget: self associateElement;
			 yourself)
]

{ #category : #initialization }
ToContextMenu >> defaulPositionHook [

	^ [ :w :event | event position ]
]

{ #category : #initialization }
ToContextMenu >> initialize [

	super initialize.
	self initializeMenuItemHolder.

]

{ #category : #testing }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #'api - displaying' }
ToContextMenu >> popupEvent: anEvent [

	self flag: '#openedContextMenu: and #requestFocus should not be sent directly like that. One should be sure that that the popup is done (eventHandler on ToWindowOpenedEvent ?)'.
	self associateElement ifNotNil: [ :w | w openedContextMenu: self ].
	self requestFocus.
	super popupEvent: anEvent
]

{ #category : #'t - menu window model - accessing' }
ToContextMenu >> window [

	^ self 
]
