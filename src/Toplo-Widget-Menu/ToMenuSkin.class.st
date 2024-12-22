Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu
			ifTrue: [
				| arrowTk |
				e endFlexible: true.
				e endInterspace: 10.
				arrowTk := e isInline
					           ifTrue: [
						           e isOpened
							           ifTrue: [ #'submenu-arrow-up' ]
							           ifFalse: [ #'submenu-arrow-down' ] ]
					           ifFalse: [ #'submenu-arrow-right' ].
				e endElement addChild: (e valueOfTokenNamed: arrowTk) value ]
			ifFalse: [
				(e hasIcon and: [ e hasLabel ])
					ifTrue: [
					e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
					ifFalse: [ e startInterspace: 0 ] ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e endElement removeChildren ]
]
