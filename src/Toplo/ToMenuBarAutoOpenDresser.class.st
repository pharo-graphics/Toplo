Class {
	#name : #ToMenuBarAutoOpenDresser,
	#superclass : #ToDresser,
	#instVars : [
		'overHandler',
		'menuBarDresser',
		'mouseEventOutsideHandler'
	],
	#category : #'Toplo-Widget-MenuBar'
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
			                           mouseOutside: event
			                           in: anElement ].
	anElement addEventHandler: overHandler.
	anElement space layerHolder addEventHandler: mouseEventOutsideHandler
]

{ #category : #accessing }
ToMenuBarAutoOpenDresser >> menuBarDresser: anInstaller [

	menuBarDresser := anInstaller 
]

{ #category : #'api - accessing' }
ToMenuBarAutoOpenDresser >> mouseOutside: anEvent in: aMenuBar [ 

	anEvent originalEvent currentTarget ifNotNil: [ :t |
		(t hasInParentChain: aMenuBar) ifTrue: [ ^ self ] ].
	self removeAutoOpenDresserIn: aMenuBar
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> mouseOver: anEvent in: anElement [
	" auto-open action "

	anElement menus do: [ :m |
		(anEvent target hasInParentChain: m)
			ifTrue: [ m menuWindow popupEvent: anEvent ]
			ifFalse: [ m menuWindow close ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> removeAutoOpenDresserIn: anElement [

	menuBarDresser removeAutoOpenDresserIn: anElement.
	menuBarDresser := nil

]

{ #category : #'api - install/uninstall  hook' }
ToMenuBarAutoOpenDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: overHandler.
	anElement space layerHolder removeEventHandler: mouseEventOutsideHandler.
	overHandler := nil.
	mouseEventOutsideHandler := nil.
	super uninstallEventListenersIn: anElement
]
