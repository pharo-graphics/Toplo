Class {
	#name : #ToTabInvisibleNodesMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #'event handling' }
ToTabInvisibleNodesMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconImage: (self menuImageIn: e tabGroupElement).
		e icon extent: 20 asPoint.
		e tabGroupElement checkInvisibleNodes ]
]

{ #category : #private }
ToTabInvisibleNodesMenuSkin >> menuImageIn: aTabGroupElement [

	^ aTabGroupElement isHorizontal
		  ifTrue: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morehoriz' ]
		  ifFalse: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morevert' ]
]
