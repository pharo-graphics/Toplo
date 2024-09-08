Class {
	#name : #ToMultiSelectElementCheckSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Examples'
}

{ #category : #'event handling' }
ToMultiSelectElementCheckSkin >> installSkinEvent: anEvent [

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

{ #category : #'event handling' }
ToMultiSelectElementCheckSkin >> pathCheckSVG [

	^ '<?xml version="1.0" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 1024 1024">
  <path d="M912 190h-69.9c-9.8 0-19.1 4.5-25.1 12.2L404.7 724.5 207 474a32 32 0 0 0-25.1-12.2H112c-6.7 0-10.4 7.7-6.3 12.9l273.9 347c12.8 16.2 37.4 16.2 50.3 0l488.4-618.9c4.1-5.1.4-12.8-6.3-12.8z"/>
</svg>'
]
