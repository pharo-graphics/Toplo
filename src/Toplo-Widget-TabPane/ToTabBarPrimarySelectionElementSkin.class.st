Class {
	#name : #ToTabBarPrimarySelectionElementSkin,
	#superclass : #ToListPrimarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane-TabBar'
}

{ #category : #'event handling' }
ToTabBarPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e visibility: e nodeContainer visibility ]
]
