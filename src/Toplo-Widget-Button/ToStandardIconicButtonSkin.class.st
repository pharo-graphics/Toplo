Class {
	#name : #ToStandardIconicButtonSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToStandardIconicButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| pad |
			pad := e valueOfTokenNamed: #'padding-iconic-button'.
			e padding: (BlInsets all: pad).
			e
				withStamp: #color
				do: [ :v | color := v ]
				ifNone: [ color := e valueOfTokenNamed: #'color-text' ].
			e extent: ((e valueOfTokenNamed: #'font-size') + pad) asPoint ]
]
