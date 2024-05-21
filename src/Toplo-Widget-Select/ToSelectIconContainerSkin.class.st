Class {
	#name : #ToSelectIconContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'event handling' }
ToSelectIconContainerSkin >> closedLookEvent: anEvent [

	super closedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon: self popupClosedIcon   ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink  ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e middleContainer padding: (BlInsets horizontal: 5).
		e icon ifNil: [ e icon: self popupClosedIcon ] ]
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectIconContainerSkin >> openedLookEvent: anEvent [

	super openedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon: (e isForFiltering
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
ToSelectIconContainerSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
