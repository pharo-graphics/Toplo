Class {
	#name : #ToMenuSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuSkin >> arrowImageFor: aMenuItem [

	^ aMenuItem hasInlineWindow 
		  ifTrue: [
				  aMenuItem isOpened
					  ifTrue: [ ToIconicArrowButton up ]
					  ifFalse: [ ToIconicArrowButton down ] ]
		  ifFalse: [
				  aMenuItem isSubmenu
					  ifTrue: [ ToIconicArrowButton right ]
					  ifFalse: [
							  (aMenuItem isMenuPaneMenu and: [
								   aMenuItem menuPane isHorizontal ])
								  ifTrue: [ ToIconicArrowButton down ]
								  ifFalse: [ ToIconicArrowButton right ] ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e isCircularMenuItem
				ifTrue: [ e background: Color transparent ]
				ifFalse: [
						e parentMenuOrMenuPane ifNil: [
							e background: (e valueOfTokenNamed: #'color-bg-container') ] ].
			((e isSubmenu and: [ e isCircularMenuItem not ]) or: [ e showExpandIcon ]) ifTrue: [
					| arrowIm |
					arrowIm := self arrowImageFor: e.
					arrowIm extent:
						(e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint.
					e endElement addChild: arrowIm ].
			(e hasIcon and: [ e hasLabel ]) ifFalse: [ e startInterspace: 0 ] ]
]

{ #category : #'event handling' }
ToMenuSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e endElement removeChildren ]
]
