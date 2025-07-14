Class {
	#name : #ToIconicAddButtonSkin,
	#superclass : #ToStandardIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToIconicAddButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e innerImage:
			(ToMaterialDesignIconProvider innerImageNamed: 'outlined_add') ]
]
