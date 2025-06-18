Class {
	#name : #ToTabBarSecondarySelectionElementSkin,
	#superclass : #ToListSecondarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #'event handling' }
ToTabBarSecondarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e listElement isFlowable ifFalse: [
			e visibility: e node visibility.
			e background:
				(e valueOfTokenNamed: #'tab-color-secondary-selection') ] ]
]
