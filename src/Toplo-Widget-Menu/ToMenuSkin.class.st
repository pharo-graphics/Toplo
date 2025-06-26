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
						| arrowIm |
						arrowIm := e isInline
							           ifTrue: [
									           e isOpened
										           ifTrue: [ ToIconicArrowButton up ]
										           ifFalse: [ ToIconicArrowButton down ] ]
							           ifFalse: [
									           e isSubmenu
										           ifTrue: [ ToIconicArrowButton right ]
										           ifFalse: [
												           (e isMenuPaneMenu and: [
													            e menuPane isHorizontal ])
													           ifTrue: [ ToIconicArrowButton down ]
													           ifFalse: [ ToIconicArrowButton right ] ] ].
						arrowIm size:
							(e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint.
						e endElement addChild: arrowIm.
						e isSubmenu
							ifTrue: [
							e endInterspace:
								(e valueOfTokenNamed: #'menu-item-end-interspace') ]
							ifFalse: [
							e endInterspace: (e valueOfTokenNamed: #'button-interspace') ] ]
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
