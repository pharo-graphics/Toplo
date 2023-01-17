Class {
	#name : #ToOverlayWindowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'closeHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> installEventListenersIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement


]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToOverlayWindowDresser >> uninstallEventListenersIn: anElement [


]
