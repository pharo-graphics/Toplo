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
		                do: [ :event | self mouseDownOutside: event receivedIn: anElement ].
	anElement addEventHandler: closeHandler
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> mouseDownOutside: anEvent receivedIn: aMenuWindow [

	anEvent currentTarget close
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToPopupWindowDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: closeHandler
]
