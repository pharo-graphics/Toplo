Class {
	#name : #ToIconicRemoveButtonSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToIconicRemoveButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (e valueOfTokenNamed: #'border-color-danger-selection') ]
]

{ #category : #'event handling' }
ToIconicRemoveButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e innerImage:
			(ToMaterialDesignIconProvider innerImageNamed: 'outlined_close') ]
]

{ #category : #'event handling' }
ToIconicRemoveButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color transparent ]
]

{ #category : #'event handling' }
ToIconicRemoveButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color transparent ]
]
