Class {
	#name : #ToTabNodeMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabNodeMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tabsElement |
		tabsElement := e tabsElement.
		tabsElement invisibleNodes
			ifEmpty: [ e visibility: BlVisibility gone ]
			ifNotEmpty: [ e visibility: BlVisibility visible ].
		e background: (e valueOfTokenNamed: #'background-color') ]
]
