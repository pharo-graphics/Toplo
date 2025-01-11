Class {
	#name : #ToMenuBarSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'event handling' }
ToMenuBarSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemList background: BlBackground transparent.
		e barParent ifNotNil: [
			e background: (Color veryLightGray alpha: 0.1) ] ]
]

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
		e barParent ifNil: [
			e padding: (BlInsets all: 4) ].
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToMenuBarSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemList background: BlBackground transparent.
		e barParent ifNotNil: [
			e background: BlBackground transparent ] ]
]
