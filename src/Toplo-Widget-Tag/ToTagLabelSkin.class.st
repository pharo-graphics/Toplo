Class {
	#name : #ToTagLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #'event handling' }
ToTagLabelSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e foreground: (e valueOfTokenNamed: #'color-text-disabled') ]
]

{ #category : #'event handling' }
ToTagLabelSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| foregroundColor defaultToken |
		defaultToken := #'border-color-primary-selection'.
		e
			withStamp: #'parent-tag'
			do: [ :tag |
				tag
					withStamp: #foregroundColor
					do: [ :v | foregroundColor := v ]
					ifNone: [ foregroundColor := e valueOfTokenNamed: defaultToken ] ]
			ifNone: [ foregroundColor := e valueOfTokenNamed: defaultToken ].
		e foreground: foregroundColor ]
]

{ #category : #'event handling' }
ToTagLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder
			weight: (e valueOfTokenNamed: #'font-weight-strong');
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height').
		e applyStyle ]
]
