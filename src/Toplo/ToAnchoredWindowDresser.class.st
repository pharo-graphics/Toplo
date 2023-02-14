Class {
	#name : #ToAnchoredWindowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'closeHandler'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToAnchoredWindowDresser >> installEventListenersIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToAnchoredWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToAnchoredWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToAnchoredWindowDresser >> uninstallEventListenersIn: anElement [


]
