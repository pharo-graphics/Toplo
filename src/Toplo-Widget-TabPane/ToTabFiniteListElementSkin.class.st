Class {
	#name : #ToTabFiniteListElementSkin,
	#superclass : #ToItemFiniteListElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e border: BlBorder empty.
			e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]
