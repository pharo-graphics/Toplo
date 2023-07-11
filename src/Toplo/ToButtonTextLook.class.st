Class {
	#name : #ToButtonTextLook,
	#superclass : #ToButtonUnborderedLook,
	#category : #'Toplo-Widget-Button-Look'
}

{ #category : #'event handling' }
ToButtonTextLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: e toTheme colorBgTextHover ]
]

{ #category : #'event handling' }
ToButtonTextLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: e toTheme colorBgTextActive ]
]
