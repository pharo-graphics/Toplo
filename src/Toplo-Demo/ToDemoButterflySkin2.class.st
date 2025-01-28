Class {
	#name : #ToDemoButterflySkin2,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #'event handling' }
ToDemoButterflySkin2 >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-success') ]
]

{ #category : #'event handling' }
ToDemoButterflySkin2 >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| im |
		e layout: BlFrameLayout new.
		im := ToImage new innerImage: ToThemeIcons searchOutlined16x16.
		im constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
		e addChild: im.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-LG')).
		e background: (e valueOfTokenNamed: #'color-primary').
		e border: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToDemoButterflySkin2 >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToDemoButterflySkin2 >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeChildren ]
]
