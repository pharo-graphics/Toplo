Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

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
		e isSubmenu
			ifTrue: [
				e endFlexible: true.
				e endElement addChild: (ToAttributedLabel new
						 text: '>' asRopedText;
						 foreground: Color veryLightGray;
						 yourself) ]
			ifFalse: [
				(e hasIcon and: [ e hasLabel ])
					ifTrue: [
					e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
					ifFalse: [ e startInterspace: 0 ] ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu ifFalse: [
			e border: (BlBorder
					 paint: (e valueOfTokenNamed: #'color-bg-container')
					 width: (e valueOfTokenNamed: #'line-width')) ] ]
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
