Class {
	#name : #ToTabListElementSkin,
	#superclass : #ToItemListElementSkin,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #'event handling' }
ToTabListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e border: BlBorder empty.
			e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToTabListElementSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]
