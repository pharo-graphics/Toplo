Class {
	#name : #ToPopupWindowDresser,
	#superclass : #ToBasicWindowDresser,
	#instVars : [
		'closeHandler',
		'widgetPositionHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	closeHandler := BlEventHandler
		                on: BlSpaceMouseDownOutsideEvent
		                do: [ :event | self mouseDownOutside: event receivedIn: anElement ].
	anElement addEventHandler: closeHandler
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> installWidget: newWidget in: anElement [

	super installWidget: newWidget in: anElement.
	newWidget ifNil: [ ^ self  ].
	widgetPositionHandler := BlEventHandler
		                         on: BlElementPositionChangedEvent
		                         do: [ :event | anElement close ].
	newWidget addEventHandler: widgetPositionHandler
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> mouseDownOutside: anEvent receivedIn: aMenuWindow [

	anEvent currentTarget close.
	anEvent consumed: true
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement effect:
		(BlGaussianShadowEffect
			 color: Color gray
			 width: 5
			 offset: 2 asPoint)	



]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	anElement removeEventHandler: closeHandler.
	closeHandler := nil
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallWidget: oldWidget in: anElement [

	super uninstallWidget: oldWidget in: anElement.
	oldWidget ifNil: [ ^ self ].
	oldWidget removeEventHandler: widgetPositionHandler.
	widgetPositionHandler := nil
]
