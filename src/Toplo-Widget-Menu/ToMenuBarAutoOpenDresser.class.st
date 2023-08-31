Class {
	#name : #ToMenuBarAutoOpenDresser,
	#superclass : #ToDresser,
	#instVars : [
		'overHandler',
		'menuBarDresser',
		'mouseEventOutsideHandler'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	overHandler := BlEventHandler
		               on: BlMouseOverEvent
		               do: [ :event | self mouseOver: event in: anElement ].
	mouseEventOutsideHandler := BlEventHandler
		                           on: BlMouseUpOutsideEvent
		                           do: [ :event |
		                           self
			                           mouseUpOutside: event
			                           in: anElement ].
	anElement addEventHandler: overHandler.
	anElement addEventFilter: mouseEventOutsideHandler
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
			ifTrue: [ m popupEvent: anEvent ]
			ifFalse: [ m close ] ]
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenDresser >> mouseUpOutside: anEvent in: aMenuBar [

	anEvent originalEvent target ifNil: [ ^ self ].
	(anEvent originalEvent target hasInParentChain: aMenuBar)
		ifTrue: [ ^ self ].
	anEvent consumed: true.
	self removeAutoOpenDresserIn: aMenuBar
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> removeAutoOpenDresserIn: anElement [

	menuBarDresser removeAutoOpenDresserIn: anElement.
	menuBarDresser := nil

]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: overHandler.
	anElement removeEventFilter: mouseEventOutsideHandler.
	overHandler := nil.
	mouseEventOutsideHandler := nil.
	super uninstallEventListenersIn: anElement
]
