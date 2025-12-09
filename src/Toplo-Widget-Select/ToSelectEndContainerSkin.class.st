Class {
	#name : #ToSelectEndContainerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectEndContainerSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e icon beUp ]
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImageColor: (e valueOfTokenNamed: #'color-text-disabled').
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImageColor: (e valueOfTokenNamed: #'color-text') ].
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink  ].
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e padding: (BlInsets horizontal: 5).
			e middleContainer padding: (BlInsets horizontal: 5).
			e icon ifNil: [
					| image |
					image := ToIconicArrowButton up.
					image extent:
						(e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint.
					e icon: image ] ]
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal  ].
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e icon beDown ]
]

{ #category : #'event handling' }
ToSelectEndContainerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
