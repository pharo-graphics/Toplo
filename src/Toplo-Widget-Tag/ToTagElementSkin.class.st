Class {
	#name : #ToTagElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'event handling' }
ToTagElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToTagElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| backgroundColor foregroundColor defaultToken |
		defaultToken := #'border-color-primary-selection'.
		e
			withStamp: #'foreground-color'
			do: [ :v | foregroundColor := v ]
			ifNone: [ foregroundColor := e valueOfTokenNamed: defaultToken ].
		defaultToken := #'color-primary-selection-unfocused'.
		e
			withStamp: #'background-color'
			do: [ :v | backgroundColor := v ]
			ifNone: [ backgroundColor := e valueOfTokenNamed: defaultToken ].

		e background: backgroundColor.
		e labelDo: [ :lab |
			lab addTokenNamed: #'color-text' withValue: foregroundColor ].
		e removeButtonDo: [ :rb |
			rb addStamp: #color withValue: foregroundColor ].

		(e hasStamp: #borderless)
			ifTrue: [ e border: BlBorder empty ]
			ifFalse: [
				e border: (BlBorder
						 paint: foregroundColor
						 width: (e valueOfTokenNamed: #'line-width')) ] ]
]

{ #category : #'event handling' }
ToTagElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e |
			| leftPad rightPad topPad bottomPad |
			leftPad := rightPad := e valueOfTokenNamed: #'padding-XXS'.
			topPad := bottomPad := e valueOfTokenNamed: #'padding-XXS'.
			e removeButtonDo: [ :rb |
					rb constraintsDo: [ :c |
							leftPad := leftPad + 15.
							c ignored horizontal alignLeft.
							c ignored vertical alignCenter ] ].

			e holderDo: [ :h |
					e margin:
						(BlInsets horizontal:
							 (e valueOfTokenNamed: #'padding-XXS')) ].

			e padding: (BlInsets
					 top: topPad
					 left: leftPad
					 bottom: bottomPad
					 right: rightPad).

			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: 'border-radius')).
			(e hasIcon and: [ e hasLabel ])
				ifTrue: [
				e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
				ifFalse: [ e startInterspace: 0 ].
			(e hasEndElement and: [ e hasLabel ])
				ifTrue: [
				e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
				ifFalse: [ e endInterspace: 0 ] ]
]
