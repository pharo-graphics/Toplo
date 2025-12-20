Class {
	#name : #ToItemNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Core-Item'
}

{ #category : #'event handling' }
ToItemNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e item ifNotNil: [:it | it constraintsDo: [ :c | c linear vertical alignCenter ] ] ]
]
