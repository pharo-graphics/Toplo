Class {
	#name : #ToCircularMenuPaneSkin,
	#superclass : #ToMenuPaneSkin,
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #'event handling' }
ToCircularMenuPaneSkin >> installSkinEvent: anEvent [
	"Pay attention to not send a message which consequence is the itemList datasource update 
	(because in this case, the opened menu window will be closed)."

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e geometry: BlCircleGeometry new ]
]
