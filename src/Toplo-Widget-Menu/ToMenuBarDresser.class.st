Class {
	#name : #ToMenuBarDresser,
	#superclass : #ToDresser,
	#instVars : [
		'autoOpenDresser',
		'mouseDownHandler'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	mouseDownHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :event | self mouseDown: event in: anElement ].
	anElement addEventHandler: mouseDownHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> mouseDown: anEvent in: anElement [
	"switch auto=open dresser "

	" mouse down on the menubar or in a menubar child while the auto open dresser is installed "
	(anEvent target = anElement or: [ autoOpenDresser notNil ]) ifTrue: [
		^ self removeAutoOpenDresserIn: anElement ].

	autoOpenDresser := ToMenuBarAutoOpenDresser new menuBarDresser: self.
	" add the dresser that makes menu opening on mouse over. 
	This dresser will remove itself in case of a mouse down outside "
	anElement addDresser: autoOpenDresser
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

	anElement removeDresser: autoOpenDresser.
	autoOpenDresser := nil
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: mouseDownHandler.
	self removeAutoOpenDresserIn: anElement.
	super uninstallEventListenersIn: anElement
]
