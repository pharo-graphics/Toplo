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
			e parentMenuDo: [ :pm |
				(pm items anySatisfy: [ :mi | mi hasIcon ]) ifTrue: [
					e button startAlignment:
						(e valueOfTokenNamed: #'menu-item-start-alignment') ] ] ].
		e isTopMenu ifFalse: [
			e parentMenuDo: [ :pm |
				(pm items anySatisfy: [ :mi | mi isMenu ]) ifTrue: [
					e isStartToEnd
						ifTrue: [
							e endInterspace: 10.
							e endFlexible: true ]
						ifFalse: [
							e startInterspace: 10.
							e startFlexible: true ] ] ] ] ]
]
