Class {
	#name : #ToDemoButterflySkin2,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #'event handling' }
ToDemoButterflySkin2 >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-success') ]
]

{ #category : #'event handling' }
ToDemoButterflySkin2 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
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
ToDemoButterflySkin2 >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToDemoButterflySkin2 >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeChildren ]
]