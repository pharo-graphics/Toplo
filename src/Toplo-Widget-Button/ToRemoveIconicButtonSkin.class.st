Class {
	#name : #ToRemoveIconicButtonSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'as yet unclassified' }
ToRemoveIconicButtonSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		| foreground |
		foreground := e valueOfTokenNamed: #'color-text'.
		e
			withStamp: #'parent-tag'
			do: [ :tag |
			tag withStamp: #foregroundColor do: [ :v | foreground := v ] ].
		e innerImageColor: foreground ]
]

{ #category : #'as yet unclassified' }
ToRemoveIconicButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| foreground |
		foreground := e valueOfTokenNamed: #'color-text'.
		e
			withStamp: #'parent-tag'
			do: [ :tag |
			tag withStamp: #foregroundColor do: [ :v | foreground := v ] ].
		e innerImageColor: foreground ]
]

{ #category : #'event handling' }
ToRemoveIconicButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e innerImage:
			(ToMaterialDesignIconProvider innerImageNamed: 'outlined_close') ]
]
