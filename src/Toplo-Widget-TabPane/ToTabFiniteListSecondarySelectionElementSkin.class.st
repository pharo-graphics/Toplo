Class {
	#name : #ToTabFiniteListSecondarySelectionElementSkin,
	#superclass : #ToListSecondarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #'event handling' }
ToTabFiniteListSecondarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e listElement isFlowable ifFalse: [
					e visibility: e nodeContainer visibility.
					e background:
						(e valueOfTokenNamed: #'tab-color-secondary-selection') ] ]
]
