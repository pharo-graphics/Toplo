Class {
	#name : #ToStandardWindowStarter,
	#superclass : #ToWindowStarter,
	#category : #'Toplo-Core-Window'
}

{ #category : #'private - layout' }
ToStandardWindowStarter >> anchorElementExtentChangedEvent: anEvent [

	anEvent currentTarget manager currentWindowDo: [ :w |
		w refreshLayout ]
]

{ #category : #'private - layout' }
ToStandardWindowStarter >> anchorElementExtentChangedEvent: anEvent fromManager: aManager [

	aManager currentWindowDo: [ :w |
		w refreshLayout ]
]

{ #category : #'private - layout' }
ToStandardWindowStarter >> anchorElementPositionChangedEvent: anEvent [

	anEvent currentTarget manager currentWindowDo: [ :w |
		w refreshLayout ]
]

{ #category : #'private - layout' }
ToStandardWindowStarter >> anchorElementPositionChangedEvent: anEvent fromManager: aManager [

	aManager currentWindowDo: [ :w |
		w refreshLayout ]
]

{ #category : #'starting-stopping' }
ToStandardWindowStarter >> startWindow: aWindow fromManager: aManager  onEvent: anEvent [

	aWindow lastPopupEvent: anEvent.
	aWindow localTheme ifNil: [
		aWindow localTheme: aManager anchorElement lookupTheme ].
	aWindow refreshLayout.
	aManager anchorRoot addChild: aWindow
]

{ #category : #'starting-stopping' }
ToStandardWindowStarter >> stopWindow: aWindow fromManager: aManager [

	aWindow removeFromParent
]
