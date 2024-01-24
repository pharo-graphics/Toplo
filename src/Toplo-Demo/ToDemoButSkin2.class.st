Class {
	#name : #ToDemoButSkin2,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2-ButterflyTheme'
}

{ #category : #'event handling' }
ToDemoButSkin2 >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e tokenValueNamed: #'color-success') ]
]

{ #category : #'event handling' }
ToDemoButSkin2 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| im |
		e layout: BlFrameLayout new.
		im := ToImage new innerImage: ToThemeIcons iconSearchOutlined16x16.
		im constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
		e addChild: im.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e tokenValueNamed: #'border-radius-LG')).
		e background: (e tokenValueNamed: #'color-primary').
		e border: (e tokenValueNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToDemoButSkin2 >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e tokenValueNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToDemoButSkin2 >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeChildren ]
]
