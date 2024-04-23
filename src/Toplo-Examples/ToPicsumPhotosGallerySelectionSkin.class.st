Class {
	#name : #ToPicsumPhotosGallerySelectionSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Examples'
}

{ #category : #'event handling' }
ToPicsumPhotosGallerySelectionSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| im cont |
		cont := BlElement new
			        geometry: BlCircleGeometry new;
			        background: Color yellow;
			        layout: BlFrameLayout new;
			        yourself.
		cont constraintsDo: [ :c |
			c frame vertical alignBottom.
			c frame horizontal alignRight.
			c vertical fitContent.
			c horizontal fitContent ].
		im := ToImage svgPathString: self pathCheckSVG.
		im size: 25 asPoint.
		cont addChild: im.
		e layout: BlFrameLayout new.
		e padding: (BlInsets all: 8).
		e addChild: cont ]
]

{ #category : #'event handling' }
ToPicsumPhotosGallerySelectionSkin >> pathCheckSVG [

	<sampleInstance>
	^ '<?xml version="1.0" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 1024 1024">
  <path d="M912 190h-69.9c-9.8 0-19.1 4.5-25.1 12.2L404.7 724.5 207 474a32 32 0 0 0-25.1-12.2H112c-6.7 0-10.4 7.7-6.3 12.9l273.9 347c12.8 16.2 37.4 16.2 50.3 0l488.4-618.9c4.1-5.1.4-12.8-6.3-12.8z"/>
</svg>'
]