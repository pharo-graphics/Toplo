Class {
	#name : #ToToggleButtonSkin,
	#superclass : #ToGeneralButtonSkin,
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
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ].
		e isMenuButton
			ifTrue: [ e background: BlBackground transparent ]
			ifFalse: [
				e background: (e valueOfTokenNamed: #'color-primary-unchecked').
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'color-border')
						 width: (e valueOfTokenNamed: #'line-width')) ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-indeterminate').
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e layout alignCenter.
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [
			e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [
			e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e endInterspace: 0 ] ]
]

{ #category : #'event handling' }
ToToggleButtonSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isMenuButton
			ifTrue: [ e background: BlBackground transparent ]
			ifFalse: [
			e background: (e valueOfTokenNamed: #'color-primary-unchecked') ].
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]
