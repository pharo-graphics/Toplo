Class {
	#name : #ToCircularMenuNodeContainerSkin,
	#superclass : #ToNodeContainerSkin,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
