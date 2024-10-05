Class {
	#name : #ToTagRemoveButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImageColor: Color veryLightGray ]
]

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := Color veryLightGray.
		e
			withStamp: #'parent-tag'
			do: [ :tag | tag withStamp: #foregroundColor do: [ :v | c := v ] ].
		e icon innerImageColor: c ]
]

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink.
		e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e fitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: BlBorder empty ]
]
