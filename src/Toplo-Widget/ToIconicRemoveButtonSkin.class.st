Class {
	#name : #ToIconicRemoveButtonSkin,
	#superclass : #ToStandardIconicButtonSkin,
	#category : #'Toplo-Widget-Button'
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
ToIconicRemoveButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color transparent ]
]
