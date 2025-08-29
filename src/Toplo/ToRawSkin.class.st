Class {
	#name : #ToRawSkin,
	#superclass : #ToBasicSkin,
	#traits : 'TToSkinEventListenerRegistry',
	#classTraits : 'TToSkinEventListenerRegistry classTrait',
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - event managing' }
ToRawSkin >> handleEvent: anEvent [

	super handleEvent: anEvent.
	anEvent sendToStyleSheetSkin: self
]

{ #category : #'api - hooks' }
ToRawSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement installRawStyle.
	(anElement lookupTheme applicableListenersFor: anElement)
		ifNotEmpty: [ :writers | self skinEventListeners: writers ]
]

{ #category : #'api - hooks' }
ToRawSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement uninstallRawStyle

]

{ #category : #'hook - event managing' }
ToRawSkin >> sendEventToPropertyWriters: anEvent [

	self skinEventListeners do: [ :s | s receiveEvent: anEvent  ] 
]
