Class {
	#name : #ToItemListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #'event handling' }
ToItemListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]
