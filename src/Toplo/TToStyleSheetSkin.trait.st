Trait {
	#name : #TToStyleSheetSkin,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'t - styleSheet theme - accessing writable properties' }
TToStyleSheetSkin >> forElement: anElement inTheme: aTheme [

	self skinEventListeners: (aTheme applicableListenersFor: anElement)
]

{ #category : #'t - styleSheet theme - accessing writable properties' }
TToStyleSheetSkin >> sendEventToPropertyWriters: anEvent [

	self skinEventListeners do: [ :s | s receiveEvent: anEvent  ] 
]
