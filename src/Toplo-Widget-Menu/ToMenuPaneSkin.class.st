Class {
	#name : #ToMenuPaneSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #'event handling' }
ToMenuPaneSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemList background: BlBackground transparent.
		e listElementDo: [ :l |
			e background: (Color veryLightGray alpha: 0.1) ] ]
]

{ #category : #'event handling' }
ToMenuPaneSkin >> installSkinEvent: anEvent [
	"Pay attention to not send a message which consequence is the itemList datasource update 
	(because in this case, the opened menu window will be closed)."

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e background: (e valueOfTokenNamed: #'background-color').
		e itemList background: BlBackground transparent.
		e isSubPane ifFalse: [ e padding: (BlInsets all: 4) ].
		e border: (e valueOfTokenNamed: #'border-paint') ]
]

{ #category : #'event handling' }
ToMenuPaneSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemList background: BlBackground transparent.
		e listElementDo: [ :l | e background: BlBackground transparent ] ]
]
