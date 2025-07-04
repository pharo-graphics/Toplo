Class {
	#name : #ToIconicExpandToFullScreenButtonSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #'event handling' }
ToIconicExpandToFullScreenButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e innerImage:
			(ToMaterialDesignIconProvider innerImageNamed: 'outlined_square') ]
]
