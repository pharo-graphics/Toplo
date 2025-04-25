Class {
	#name : #ToShrinkFeedbackLayerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'event handling' }
ToShrinkFeedbackLayerSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		| bg  |
		bg := e valueOfTokenNamed: #'color-bg-container'.
		e background: (BlLinearGradientPaint new
				 stops: {
						 (0 -> (bg alpha: 0.0)).
						 (0.6 -> (bg alpha: 0.0)).
						 (0.8 -> (bg alpha: 0.60)).
						 (1 -> (bg alpha: 1.0)) };
				 start: 0 @ 0;
				 end: 1 @ 1;
				 yourself) ]
]

{ #category : #'event handling' }
ToShrinkFeedbackLayerSkin >> installSkinEvent: anEvent [

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
		e background: (BlLinearGradientPaint new
				 stops: {
						 (0 -> (bg alpha: 0.0)).
						 (0.6 -> (bg alpha: 0.0)).
						 (0.8 -> (bg alpha: 0.60)).
						 (1 -> (bg alpha: 1.0)) };
				 start: 0 @ 0;
				 end: 1 @ 1;
				 yourself) ]
]

{ #category : #'event handling' }
ToShrinkFeedbackLayerSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		| bg  |
		bg := (e valueOfTokenNamed: #'color-list-primary-selection-focused').
		e background: (BlLinearGradientPaint new
				 stops: {
						 (0 -> (bg alpha: 0.0)).
						 (0.6 -> (bg alpha: 0.0)).
						 (0.8 -> (bg alpha: 0.60)).
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
