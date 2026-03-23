Class {
	#name : #ToCircularMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'event handling' }
ToCircularMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e layoutRadius: 80 ]
]
