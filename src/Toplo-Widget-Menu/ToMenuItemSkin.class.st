Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToGeneralButtonMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isTopMenu ifFalse: [
			e hMatchParent.
			e popupWindowParentMenuDo: [ :pm |
				| anyHaveIcon anyIsMenu |
				anyHaveIcon := false.
				anyIsMenu := false.
				pm collectedItemsDo: [ :item |
					item hasIcon ifTrue: [ anyHaveIcon := true ].
					item isMenu ifTrue: [ anyIsMenu := true ] ].
				anyHaveIcon ifTrue: [
					e button startAlignment:
						(e valueOfTokenNamed: #'menu-item-start-alignment') ].
				anyIsMenu ifTrue: [
					e isStartToEnd
						ifTrue: [
							e endInterspace: 10.
							e endFlexible: true ]
						ifFalse: [
							e startInterspace: 10.
							e startFlexible: true ] ] ] ] ]
]
