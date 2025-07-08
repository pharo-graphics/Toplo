Class {
	#name : #ToCheckMenuItemSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToCheckMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon extent: (e valueOfTokenNamed: #'menu-icon-size').
		e startAlignment:
			(e valueOfTokenNamed: #'menu-item-start-alignment').
		e parentMenu ifNotNil: [
			e isStartToEnd
				ifTrue: [
					e endInterspace:
						(e valueOfTokenNamed: #'menu-item-start-alignment').
					e endFlexible: true ]
				ifFalse: [
					e startInterspace:
						(e valueOfTokenNamed: #'menu-item-start-alignment').
					e startFlexible: true ] ] ]
]
