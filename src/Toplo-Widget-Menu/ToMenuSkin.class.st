Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e isSubmenu or: [ e showExpandIcon ])
			ifTrue: [
				| arrowTk arrowIm |
				arrowTk := e isInline
					           ifTrue: [
						           e isOpened
							           ifTrue: [ #'submenu-arrow-up' ]
							           ifFalse: [ #'submenu-arrow-down' ] ]
					           ifFalse: [
						           e isSubmenu
							           ifTrue: [ #'submenu-arrow-right' ]
							           ifFalse: [
								           e isOpened
									           ifTrue: [ #'submenu-arrow-up' ]
									           ifFalse: [ #'submenu-arrow-down' ] ] ].
				arrowIm := ToImage inner: (e valueOfTokenNamed: arrowTk).
				arrowIm
					size: (e valueOfTokenNamed: #'submenu-arrow-breadth') asPoint;
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
