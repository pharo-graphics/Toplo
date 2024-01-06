Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e parentMenuDo: [ :pm |
			pm items do: [ :it |
				(it isKindOf: ToMenuItem) ifTrue: [ it filler width: 10 ] ] ].

		e isSubmenu
			ifTrue: [
				e rightHandSide addChild: (ToAttributedLabel new
						 text: ('>' asRopedText foreground: Color lightGray);
						 yourself) ]
			ifFalse: [
				(e hasIcon and: [ e hasLabel ])
					ifTrue: [ e interspace: 10 ]
					ifFalse: [ e interspace: 0 ] ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e | e rightHandSide removeChildren ]
]
