Class {
	#name : #ToSelectIconContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectIconContainerSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e icon innerImage: (e valueOfTokenNamed: #'submenu-arrow-up') ]
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink  ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e middleContainer padding: (BlInsets horizontal: 5).
		e icon ifNil: [ | image |
			image := ToImage inner: (e valueOfTokenNamed: #'submenu-arrow-up').
			image size: 18 asPoint.
			image innerImageColor: (e valueOfTokenNamed: #'color-text').
			e icon: image ] ]
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e icon innerImage: (e valueOfTokenNamed: #'submenu-arrow-down') ]
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
