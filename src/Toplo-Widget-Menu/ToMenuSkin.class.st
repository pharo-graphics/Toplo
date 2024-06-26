Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

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
				e endElement addChild: (ToAttributedLabel new
						 text: ('>' asRopedText foreground: Color lightGray);
						 yourself) ]
			ifFalse: [
				(e hasIcon and: [ e hasLabel ])
					ifTrue: [ e startInterspace: 10 ]
					ifFalse: [ e startInterspace: 0 ] ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e endElement removeChildren ]
]
