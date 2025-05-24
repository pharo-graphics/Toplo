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
							           ifTrue: [ #'iconic-arrow-up' ]
							           ifFalse: [ #'iconic-arrow-down' ] ]
					           ifFalse: [
						           e isSubmenu
							           ifTrue: [ #'iconic-arrow-right' ]
							           ifFalse: [
								           e isOpened
									           ifTrue: [ #'iconic-arrow-up' ]
									           ifFalse: [ #'iconic-arrow-down' ] ] ].
				arrowIm := ToImage inner: (e valueOfTokenNamed: arrowTk).
				arrowIm
					size: (e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint;
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
