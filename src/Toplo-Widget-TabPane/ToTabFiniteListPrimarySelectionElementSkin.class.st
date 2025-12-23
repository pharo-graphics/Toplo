Class {
	#name : #ToTabFiniteListPrimarySelectionElementSkin,
	#superclass : #ToListPrimarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabFiniteListPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e visibility: e nodeContainer visibility ]
]
