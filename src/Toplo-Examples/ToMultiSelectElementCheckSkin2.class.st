Class {
	#name : #ToMultiSelectElementCheckSkin2,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToMultiSelectElementCheckSkin2 >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| im cont bar w background |
		w := 2.
		e background: BlBackground transparent.
		background := e valueOfTokenNamed: #'border-color-primary-selection'.
		bar := BlElement new
			       width: w;
			       yourself.
		bar background: background.
		bar constraintsDo: [ :c |
			c vertical matchParent.
			c frame horizontal alignLeft ].
		e addChild: bar.
		cont := BlElement new
			        geometry: BlCircleGeometry new;
			        layout: BlFrameLayout new;
			        yourself.
		im := ToImage inner: self pathCheckSVG.
		im innerImage firstChild background: background.
		im margin: (BlInsets right: 20).
		im constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignRight ].
		im size: 16 asPoint.
		im background: Color transparent.
		e layout: BlFrameLayout new.
		e addChild: im ]
]
