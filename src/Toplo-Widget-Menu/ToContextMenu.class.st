Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu window model - accessing' }
ToContextMenu >> associateWindow [

	^ self 
]

{ #category : #'t - menu window model - window opening/closing' }
ToContextMenu >> close [

	super close
]

{ #category : #initialization }
ToContextMenu >> defaulPositionHook [

	^ [ :w :event | event position ]
]

{ #category : #testing }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #'t - menu item holder - accessing' }
ToContextMenu >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #'api - displaying' }
ToContextMenu >> popupEvent: anEvent [

	self flag: '#openedContextMenu: and #requestFocus should not be sent directly like that. One should be sure that that the popup is done (eventHandler on ToWindowOpenedEvent ?)'.
	self associateElement ifNotNil: [ :w | w openedContextMenu: self ].
	self requestFocus.
	super popupEvent: anEvent
]

{ #category : #'t - menu window model - accessing' }
ToContextMenu >> rootMenu [

	^ self 
]
