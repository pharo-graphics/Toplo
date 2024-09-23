Class {
	#name : #ToToggleButtonSkin,
	#superclass : #ToBasicSkin,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToToggleButtonSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-checked').
		e iconDo: [ :ic |
			ic innerImageColor:
				(e valueOfTokenNamed: #'text-color-primary-checked') ].
		e labelDo: [ :lab | 
			lab foreground:  
					 (e valueOfTokenNamed: #'text-color-primary-checked').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text-disabled')) } ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-hover')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-indeterminate').
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) } ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e layout alignCenter.
		e mouseCursor: Cursor normal.
		"e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius'))."
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')).
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-XS')).
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [ e startInterspace: 10 ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [ e endInterspace: 10 ]
			ifFalse: [ e endInterspace: 0 ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-unchecked').
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) } ] ]
]
