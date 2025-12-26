Class {
	#name : #ToMenuItemNodeSkin,
	#superclass : #ToItemNodeSkin,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'event handling' }
ToMenuItemNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
