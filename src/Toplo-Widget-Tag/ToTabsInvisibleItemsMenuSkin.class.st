Class {
	#name : #ToTabsInvisibleItemsMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabsInvisibleItemsMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconImage: (self menuImageIn: e tabsElement).
		e icon size: 20 asPoint.
		e tabsElement checkInvisibleNodesMenu ]
]

{ #category : #private }
ToTabsInvisibleItemsMenuSkin >> menuImageIn: aTabsElement [

	^ aTabsElement isHorizontal
		  ifTrue: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morehoriz' ]
		  ifFalse: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morevert' ]
]
