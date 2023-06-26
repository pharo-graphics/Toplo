Class {
	#name : #ToMenuBarAutoOpenDresser,
	#superclass : #ToDresser,
	#instVars : [
		'overHandler',
		'menuBarDresser',
		'mouseDownOutsideHandler'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	overHandler := BlEventHandler
		               on: BlMouseOverEvent
		               do: [ :event | self mouseOver: event in: anElement ].
	mouseDownOutsideHandler := BlEventHandler
		                           on: BlSpaceMouseDownOutsideEvent
		                           do: [ :event |
		                           self
			                           mouseDownOutside: anElement
			                           event: event ].
	anElement addEventHandler: overHandler.
	anElement space layerHolder addEventHandler: mouseDownOutsideHandler
]

{ #category : #accessing }
ToMenuBarAutoOpenDresser >> menuBarDresser: anInstaller [

	menuBarDresser := anInstaller 
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenDresser >> mouseDownOutside: aMenuBar event: anEvent [

	anEvent originalEvent currentTarget ifNotNil: [ :t |
		(t hasInParentChain: aMenuBar) ifTrue: [ ^ self ] ].
	self removeAutoOpenDresserIn: aMenuBar
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
	menuBarDresser := nil

]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: overHandler.
	anElement space layerHolder removeEventHandler: mouseDownOutsideHandler.
	overHandler := nil.
	mouseDownOutsideHandler := nil.
	super uninstallEventListenersIn: anElement
]
