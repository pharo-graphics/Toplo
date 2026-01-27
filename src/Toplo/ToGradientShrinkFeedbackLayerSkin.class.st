Class {
	#name : #ToGradientShrinkFeedbackLayerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'event handling' }
ToGradientShrinkFeedbackLayerSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| bg |
		bg := e valueOfTokenNamed: #'color-bg-container'.
		e background: (e newBackgroundRampWithColor: bg) ]
]

{ #category : #'event handling' }
ToGradientShrinkFeedbackLayerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| bg |
		bg := e valueOfTokenNamed: #'color-bg-container'.
		"inner := ToMaterialDesignIconProvider innerImageNamed:
			         'outlined_morehoriz'.
		imw := 14.
		im := ToImage inner: inner.
		im constraintsDo: [ :c |
			c horizontal exact: imw.
			c vertical matchParent ].
		im position: (e width - imw) @ 0.
		im background: bg."
		"e addChild: im."

		e background: (e newBackgroundRampWithColor: bg) ]
]

{ #category : #'event handling' }
ToGradientShrinkFeedbackLayerSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| bg |
		bg := e valueOfTokenNamed: #'color-list-primary-selection-focused'.
		e background: (e newBackgroundRampWithColor: bg) ]
]

{ #category : #'event handling' }
ToGradientShrinkFeedbackLayerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e removeChildren ]
]
