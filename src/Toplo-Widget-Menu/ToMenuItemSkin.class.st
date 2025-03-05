Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToMenuItemElementSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
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
				e button startAlignment: align ].

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
