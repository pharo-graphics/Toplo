Class {
	#name : #ToTagSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #'event handling' }
ToTagSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border-disabled')
				 width: (e valueOfTokenNamed: #'line-width')).
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		e iconDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			ic formColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToTagSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| backgroundColor foregroundColor defaultTokn |
		defaultTokn := #'border-color-primary-selection'.
		e
			withStamp: #foregroundColor
			do: [ :v | foregroundColor := v ]
			ifNone: [ foregroundColor := e valueOfTokenNamed: defaultTokn ].
		defaultTokn := #'color-primary-selection-unfocused'.
		e
			withStamp: #backgroundColor
			do: [ :v | backgroundColor := v ]
			ifNone: [ backgroundColor := e valueOfTokenNamed: defaultTokn ].

		e background: backgroundColor.
		
		e withStamp: #bordered do: [ :v |
			v
				ifTrue: [
					e border: (BlBorder
							 paint: foregroundColor
							 width: (e valueOfTokenNamed: #'line-width')) ]
				ifFalse: [ e border: BlBorder empty ] ].

		e labelDo: [ :lab | lab defaultRawSkin: ToTagLabelSkin new ] ]
]

{ #category : #'event handling' }
ToTagSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'bar-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'bar-node-padding-V')).
		(e hasIcon and: [ e hasLabel ])
			ifTrue: [ e startInterspace: 2 ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [ e endInterspace: 2 ]
			ifFalse: [ e endInterspace: 0 ] ]
]
