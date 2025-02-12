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
			| anyHaveIcon anyIsMenu align |
			
			anyHaveIcon := false.
			anyIsMenu := false.
			align := 0.0.

			e parentMenuDo: [ :pm |
				pm items do: [ :item |
					item hasIcon ifTrue: [ anyHaveIcon := true ].
					item isMenu ifTrue: [ anyIsMenu := true ] ] ].
			
			anyHaveIcon ifTrue: [
				align := e valueOfTokenNamed: #'menu-item-start-alignment' ].
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
						e startFlexible: true ] ] ] ]
]
