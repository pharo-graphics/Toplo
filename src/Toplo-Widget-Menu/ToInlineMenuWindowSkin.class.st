Class {
	#name : #ToInlineMenuWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToInlineMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color red." e padding: (BlInsets left: 10)"]
]

{ #category : #'event handling' }
ToInlineMenuWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
