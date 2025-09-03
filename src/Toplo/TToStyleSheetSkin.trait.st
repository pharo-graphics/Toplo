Trait {
	#name : #TToStyleSheetSkin,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'t - styleSheet theme - accessing writable properties' }
TToStyleSheetSkin >> sendEventToPropertyWriters: anEvent [

	self skinEventListeners do: [ :s | s receiveEvent: anEvent  ] 
]

{ #category : #'t - styleSheet theme - accessing writable properties' }
TToStyleSheetSkin >> setUpforElement: anElement inTheme: aTheme [

	self skinEventListeners: (aTheme applicableListenersFor: anElement)
]
