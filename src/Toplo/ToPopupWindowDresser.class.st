Class {
	#name : #ToPopupWindowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'closeHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> installEventListenersIn: anElement [

	closeHandler := BlEventHandler
		                on: BlSpaceMouseDownOutsideEvent
		                do: [ :event | "self mouseDownOutside: event receivedIn: anElement" ].
	anElement addEventHandler: closeHandler
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> mouseDownOutside: anEvent receivedIn: aMenuWindow [

	anEvent currentTarget close
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement whenWidgetChangedDo: [ :newWidget :oldWidget | 
		anElement uninstalledFromWidget: oldWidget.
		anElement installedInWidget: newWidget ].
	
	anElement effect:
		(BlGaussianShadowEffect
			 color: Color gray
			 width: 5
			 offset: 2 asPoint).



]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: closeHandler
]
