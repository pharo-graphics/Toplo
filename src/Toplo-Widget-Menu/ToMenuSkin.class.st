Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isSubmenu
			ifTrue: [
				| arrowTk arrowIm |
				arrowTk := e isInline
					           ifTrue: [
						           e isOpened
							           ifTrue: [ #'submenu-arrow-up' ]
							           ifFalse: [ #'submenu-arrow-down' ] ]
					           ifFalse: [ #'submenu-arrow-right' ].
				arrowIm := ToImage inner: (e valueOfTokenNamed: arrowTk).
				arrowIm
					size: 18 asPoint;
					innerImageColor: (e valueOfTokenNamed: #'color-text').
				e endElement addChild: arrowIm ]
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
