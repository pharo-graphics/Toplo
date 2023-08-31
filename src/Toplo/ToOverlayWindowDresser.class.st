Class {
	#name : #ToOverlayWindowDresser,
	#superclass : #ToBasicWindowDresser,
	#instVars : [
		'widgetExtentHandler',
		'widgetPositionInSpaceHandler'
	],
	#category : #'Toplo-window'
}

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> installWidget: newWidget in: anElement [

	super installWidget: newWidget in: anElement.
	widgetExtentHandler := BlEventHandler
		                       on: BlElementExtentChangedEvent
		                       do: [ anElement size: anElement widget size ].
	widgetPositionInSpaceHandler := BlEventHandler
		                                on: BlElementPositionInSpaceChangedEvent
		                                do: [ :event | anElement position: (anElement positioningHook value: anElement value: event) ].

	newWidget addEventHandler: widgetPositionInSpaceHandler.
	newWidget addEventHandler: widgetExtentHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	

]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> uninstallWidget: oldWidget in: anElement [

	super uninstallWidget: oldWidget in: anElement.
	oldWidget ifNil: [ ^ self ].
	oldWidget removeEventHandler: widgetExtentHandler.
	oldWidget removeEventHandler: widgetPositionInSpaceHandler.

]
