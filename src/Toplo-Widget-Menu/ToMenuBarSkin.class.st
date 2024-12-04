Class {
	#name : #ToMenuBarSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'event handling' }
ToMenuBarSkin >> installSkinEvent: anEvent [
	"Pay attention to not send a message which consequence is the itemList datasource update 
	(because in this case, the opened menu window will be closed)."

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e background: (e valueOfTokenNamed: #'background-color').
		e itemList background: BlBackground transparent.
		e border: BlBorder empty.
		e parentItemContainer ifNil: [ e padding: (BlInsets all: 4) ] ]
]
