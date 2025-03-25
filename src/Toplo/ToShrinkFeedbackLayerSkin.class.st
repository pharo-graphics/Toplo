Class {
	#name : #ToShrinkFeedbackLayerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'event handling' }
ToShrinkFeedbackLayerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| bg inner im imw |
		bg := e valueOfTokenNamed: #'color-bg-container'.
		inner := ToMaterialDesignIconProvider innerImageNamed:
			         'outlined_morehoriz'.
		imw := (e valueOfTokenNamed: #'font-size') + 10.
		im := ToImage inner: inner.
		im constraintsDo: [ :c |
			c horizontal exact: imw.
			c vertical matchParent ].
		im position: (e referenceParent width - imw) @ 0.
		im background: bg.
		"e addChild: im."
		e background: (BlLinearGradientPaint new
				 stops: {
						 (0 -> (bg alpha: 0.0)).
						 (0.65 -> (bg alpha: 0.60)).
						 (1 -> (bg alpha: 1.0)) };
				 start: 0 @ 0;
				 end: 1 @ 1;
				 yourself) ]
]

{ #category : #'event handling' }
ToShrinkFeedbackLayerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e removeChildren ]
]
