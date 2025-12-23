Class {
	#name : #ToTabListSecondarySelectionElementSkin,
	#superclass : #ToListSecondarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabListSecondarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e listElement toConfiguration isFlowable ifFalse: [
					e visibility: e nodeContainer visibility.
					e background:
						(e valueOfTokenNamed: #'tab-color-secondary-selection') ] ]
]
