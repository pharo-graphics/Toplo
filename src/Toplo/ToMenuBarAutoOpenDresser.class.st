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
	anElement space popupLayer addEventHandler: autoOpenEventHandler
]

{ #category : #accessing }
ToMenuBarAutoOpenDresser >> menuBarDresser: anInstaller [

	menuBarDresser := anInstaller 
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> mouseOver: anEvent in: anElement [
	" auto-open action "

	anElement menus do: [ :m |
		(anEvent target hasInParentChain: m)
			ifTrue: [ m subMenuWindow popupEvent: anEvent ]
			ifFalse: [ m subMenuWindow close ] ]
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
