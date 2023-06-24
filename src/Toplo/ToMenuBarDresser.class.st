Class {
	#name : #ToMenuBarDresser,
	#superclass : #ToDresser,
	#instVars : [
		'menuClickedHandler',
		'autoOpenDresser'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	menuClickedHandler := BlEventHandler on: ToButtonClickedEvent do: [ :event | self menuClicked: event in: anElement ].
	anElement addEventHandler: menuClickedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> menuClicked: anEvent in: anElement [

	autoOpenDresser ifNotNil: [ ^ self removeAutoOpenDresserIn: anElement ].
	autoOpenDresser := ToMenuBarAutoOpenDresser new menuBarDresser: self.
	" add the dresser that makes menu opening on mouse over. 
	This dresser will remove itself in case of a button clicked or a mouse down outside "
	anEvent consumed: true.
	anElement addDresser: autoOpenDresser.

]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	anElement padding: (BlInsets all: 4).
	anElement layout cellSpacing: 5
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> removeAutoOpenDresserIn: anElement [

	autoOpenDresser ifNil: [ ^ self ].
	anElement removeDresser: autoOpenDresser.
	autoOpenDresser := nil
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: menuClickedHandler.
	self removeAutoOpenDresserIn: anElement.
	super uninstallEventListenersIn: anElement
]
