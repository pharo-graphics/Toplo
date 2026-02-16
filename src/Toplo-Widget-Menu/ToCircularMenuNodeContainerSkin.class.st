Class {
	#name : #ToCircularMenuNodeContainerSkin,
	#superclass : #ToNodeContainerSkin,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border') ]
]
