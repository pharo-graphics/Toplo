Class {
	#name : #ToMenuBarSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'event handling' }
ToMenuBarSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemList uniformNodeWidth: false.
		e background: (Color veryLightGray alpha: 0.2).
		e border: BlBorder empty.
		e padding: (BlInsets all: 4) ]
]
