Class {
	#name : #ToTabBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#instVars : [
		'previousSelectionFactory'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		previousSelectionFactory := e selectionOption elementFactory.
		e isWrapping ifFalse: [
			e selectionOption elementFactory: [
				ToListPrimarySelectionElement new
					placement: (ToRawSkinTabBarSelectionPlacement new
							 tabBar: e;
							 yourself);
					measurement: (ToRawSkinTabBarSelectionMeasurement new
							 tabBar: e;
							 yourself) ] ] ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e selectionOption elementFactory: previousSelectionFactory.
		previousSelectionFactory := nil ]
]
