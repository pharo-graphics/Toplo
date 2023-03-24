Class {
	#name : #ToListElementDresser,
	#superclass : #ToDresser,
	#instVars : [
		'keyboardHandler',
		'menuPopupHandler',
		'menuCloseHandler',
		'popupNode'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListElementDresser >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : #initialization }
ToListElementDresser >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListElementDresser >> defaultPadding [

	" Must be 1 to see the focus frame AND to draw selection decoration correctly (not outside infinite bounds)  "
	^ BlInsets all: 1

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> installEventListenersIn: anElement [

	keyboardHandler := BlEventHandler on: BlKeyboardEvent do: [ :event | anElement infinite dispatchEvent: event ].
	menuPopupHandler := BlEventHandler on: ToPopupWindowOpenedEvent do: [ :event | self popupOpenedEvent: event in: anElement ].
	menuCloseHandler := BlEventHandler on: ToPopupWindowClosedEvent do: [ :event | self popupClosedEvent: event in: anElement ].

	anElement addEventHandler: keyboardHandler.
	anElement infinite addEventHandler: menuPopupHandler.
	anElement infinite addEventHandler: menuCloseHandler.

	
	
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: self defaultBackground.
	anElement margin: self defaultMargin.
	anElement padding: self defaultPadding.
	self installEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	
	self uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> popupClosedEvent: anEvent in: anElement [

	popupNode ifNil: [ ^ self ].
	(popupNode parent = anElement) ifFalse: [ ^ self ]
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> popupOpenedEvent: anEvent in: anElement [

	| pos targetChildren |
	pos := anElement infinite globalPointToLocal: anEvent sourceEvent position.
	targetChildren := (anElement infinite withAllChildrenAt: pos) allButLast.
	targetChildren ifEmpty: [ ^ self ].
	self popupOpenedEvent: anEvent onNode: targetChildren last
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> popupOpenedEvent: anEvent onNode: aChildNode [

	popupNode := aChildNode.
	popupNode holder isSelected traceCr
]

{ #category : #'api - install/uninstall  hook' }
ToListElementDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: keyboardHandler.
	anElement infinite removeEventHandler: menuPopupHandler.
	anElement infinite removeEventHandler: menuCloseHandler.


]
