Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToMenuItemElementSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-primary') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-primary') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ].
		
		(e isTopMenu not or: [ e hasStamp: #'with-expand-button' ]) ifTrue: [
			| anyHaveIcon anyIsMenu |
			anyHaveIcon := false.
			anyIsMenu := false.

			e parentMenuDo: [ :pm |
				pm items do: [ :item |
					item hasIcon ifTrue: [ anyHaveIcon := true ].
					item isMenu ifTrue: [ anyIsMenu := true ] ] ].

			anyHaveIcon ifTrue: [
				| align |
				align := e valueOfTokenNamed: #'menu-item-start-alignment'.
				e startAlignment: align ].

			(anyIsMenu or: [ e hasStamp: #'with-expand-button' ]) ifTrue: [
				e isStartToEnd
					ifTrue: [
						e endInterspace:
							(e valueOfTokenNamed: #'menu-item-start-alignment').
						e endFlexible: true ]
					ifFalse: [
						e startInterspace:
							(e valueOfTokenNamed: #'menu-item-start-alignment').
						e startFlexible: true ] ] ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor:
					(e valueOfTokenNamed: #'color-primary-pressed') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary-pressed') ] ]
]
