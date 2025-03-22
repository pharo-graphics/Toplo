Class {
	#name : #ToIconicRemoveButtonSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ToIconicRemoveButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color transparent ]
]
