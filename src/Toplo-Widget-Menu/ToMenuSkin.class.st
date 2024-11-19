Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu ifFalse: [
			e background: (e valueOfTokenNamed: #'color-bg-container-disabled') ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu ifFalse: [
			e background: (e valueOfTokenNamed: #'color-bg-container') ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu ifFalse: [
			e border: (BlBorder
					 paint: (e valueOfTokenNamed: #'color-primary-hover')
					 width: (e valueOfTokenNamed: #'line-width')) ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e parentMenuDo: [ :pm |
			pm items do: [ :it |
				(it isKindOf: ToMenuItem) ifTrue: [
					it isStartToEnd
						ifTrue: [
							it endInterspace: 10.
							it endFlexible: true ]
						ifFalse: [
							it startInterspace: 10.
							it startFlexible: true ] ] ] ].
		e isSubmenu
			ifTrue: [
				e endFlexible: true.
				e endElement addChild: (ToAttributedLabel new
						 text: '>' asRopedText;
						 foreground: Color veryLightGray;
						 yourself) ]
			ifFalse: [
				e padding: (BlInsets
						 top: (e valueOfTokenNamed: #'padding-content-V')
						 left: (e valueOfTokenNamed: #'padding-XS')
						 bottom: (e valueOfTokenNamed: #'padding-content-V')
						 right: (e valueOfTokenNamed: #'padding-XS')).
				(e hasIcon and: [ e hasLabel ])
					ifTrue: [ e startInterspace: 10 ]
					ifFalse: [ e startInterspace: 0 ] ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu ifFalse: [ e border: BlBorder empty ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu ifFalse: [
			e border: (BlBorder
					 paint: (e valueOfTokenNamed: #'color-primary-pressed')
					 width: (e valueOfTokenNamed: #'line-width')) ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e endElement removeChildren ]
]
