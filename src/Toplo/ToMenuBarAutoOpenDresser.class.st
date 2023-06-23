Class {
	#name : #ToMenuBarAutoOpenDresser,
	#superclass : #ToDresser,
	#instVars : [
		'overHandler',
		'autoOpenEventHandler',
		'menuBarDresser'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> installEventListenersIn: anElement [
	
	super installEventListenersIn: anElement.
	overHandler := BlEventHandler on: BlMouseOverEvent do: [ :event | self mouseOver: event in: anElement ].
	anElement addEventHandler: overHandler.
	autoOpenEventHandler := ToMenuBarAutoOpenEventHandler new autoOpenDresser: self; menuBar: anElement; yourself.
	anElement space layerHolder addEventHandler: autoOpenEventHandler
]

{ #category : #accessing }
ToMenuBarAutoOpenDresser >> menuBarDresser: anInstaller [

	menuBarDresser := anInstaller 
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> mouseOver: anEvent in: anElement [
	" auto-open action "

	| found |
	found := anElement menus
		         detect: [ :m | anEvent target hasInParentChain: m ]
		         ifNone: [ ^ self ].
	found subMenuWindow popupEvent: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> removeAutoOpenDresserIn: anElement [

	menuBarDresser removeAutoOpenDresserIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: overHandler.
	anElement space layerHolder removeEventHandler: autoOpenEventHandler.
	overHandler := nil.
	autoOpenEventHandler := nil.
	super uninstallEventListenersIn: anElement
]
