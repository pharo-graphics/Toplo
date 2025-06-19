Class {
	#name : #ToRawStyleSheetSkin,
	#superclass : #ToRawSkin,
	#traits : 'TToLookEventListenerRegistry',
	#classTraits : 'TToLookEventListenerRegistry classTrait',
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - hooks' }
ToRawStyleSheetSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	(anElement space toTheme applicableListenersFor: anElement) ifNotEmpty: [ :writers |
		self skinEventListeners: writers ]
]
