Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToMenuItemElementSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isTopMenu ifFalse: [
			e hMatchParent.
			e parentMenuDo: [ :pm |
				| anyHaveIcon anyIsMenu align inlineGap |
				anyHaveIcon := false.
				anyIsMenu := false.
				pm items do: [ :item |
					item hasIcon ifTrue: [ anyHaveIcon := true ].
					item isMenu ifTrue: [ anyIsMenu := true ] ].
				align := 0.0.
				inlineGap := e valueOfTokenNamed: #'inline-item-gap'.
				anyHaveIcon ifTrue: [
					align := e valueOfTokenNamed: #'menu-item-start-alignment' ].
				e isInInlineWindow ifTrue: [
					align := align + (e inlineWindowLevel * inlineGap) ].
				e button startAlignment: align.
				anyIsMenu ifTrue: [
					e isStartToEnd
						ifTrue: [
							e endInterspace:
								(e valueOfTokenNamed: #'menu-item-start-alignment').
							e endFlexible: true ]
						ifFalse: [
							e startInterspace:
								(e valueOfTokenNamed: #'menu-item-start-alignment').
							e startFlexible: true ] ] ] ] ]
]
