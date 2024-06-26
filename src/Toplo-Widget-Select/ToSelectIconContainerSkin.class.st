Class {
	#name : #ToSelectIconContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectIconContainerSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon: self popupClosedIcon   ].
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
		e icon ifNil: [ e icon: self popupClosedIcon ] ]
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
	anEvent elementDo: [ :e |
		e icon: (e isSelectFiltrable
			 ifTrue: [ self searchIcon ]
			 ifFalse: [ self popupOpenedIcon ]) ].
]

{ #category : #accessing }
ToSelectIconContainerSkin >> popupClosedIcon [

	^ ToImage inner: (self iconNamed: #bottom)
]

{ #category : #accessing }
ToSelectIconContainerSkin >> popupOpenedIcon [

	^ ToImage inner: (self iconNamed: #up)
]

{ #category : #accessing }
ToSelectIconContainerSkin >> removeAllIcon [

	^ ToImage inner: (self iconNamed: #windowClose)
]

{ #category : #accessing }
ToSelectIconContainerSkin >> searchIcon [

	^ ToImage inner: (ToThemeIcons searchOutlined16x16)
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
