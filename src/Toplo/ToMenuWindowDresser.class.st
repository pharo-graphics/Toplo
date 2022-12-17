Class {
	#name : #ToMenuWindowDresser,
	#superclass : #ToPopupWindowDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowDresser >> mouseDownOutside: anEvent receivedIn: aMenuWindow [

	" redefined to not close the menu if the mousedown occurs inside a submenu window"

	| win |
	" if I'm the original event target then do nothing"
	anEvent event currentTarget = aMenuWindow ifTrue: [ ^ self ].
	" if one of my children is the original event target then do nothing"
	anEvent event currentTarget ifNil: [ ^ super mouseDownOutside: anEvent receivedIn: aMenuWindow ].
	(anEvent event currentTarget hasParent: aMenuWindow) ifTrue: [ ^ self ].

	win := aMenuWindow currentOpenedSubmenuWindow.
	[ win notNil ] whileTrue: [ 
		" If the submenu is the original event target then do nothing"
		win = anEvent event currentTarget ifTrue: [ ^ self ].
		" If the original event target is one of the submenu child then do nothing"
		(anEvent event currentTarget hasParent: win) ifTrue: [ ^ self ].
		win := win currentOpenedSubmenuWindow ].
	
	" ok, the event is outside of the submenu chain"
	super mouseDownOutside: anEvent receivedIn: aMenuWindow
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement padding: (BlInsets all: 2).
	anElement background: (Color veryLightGray muchLighter)

]
