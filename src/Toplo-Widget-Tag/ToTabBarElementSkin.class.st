Class {
	#name : #ToTabBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#instVars : [
		'previousSelectionFactory',
		'previousSecondarySelectionFactory'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e clipChildren: false.
		e border: BlBorder empty.
		" keep the element factory to set them again on skin uninstalling "
		previousSelectionFactory := e selectionOption elementFactory.
		previousSecondarySelectionFactory := e secondarySelectionOption
			                                     elementFactory.
		" change the element factory with a specific placement and measurement "
		e selectionOption elementFactory: [
			ToTabBarPrimarySelectionElement new
				placement: (ToRawSkinTabBarSelectionPlacement new
						 tabBar: e;
						 yourself);
				measurement: (ToRawSkinTabBarSelectionMeasurement new
						 width: 4;
						 tabBar: e;
						 yourself) ].
		e secondarySelectionOption elementFactory: [
			ToTabBarSecondarySelectionElement new
				placement: (ToRawSkinTabBarSelectionPlacement new
						 tabBar: e;
						 yourself);
				measurement: (ToRawSkinTabBarSelectionMeasurement new
						 width: 2;
						 tabBar: e;
						 yourself) ] ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | " change the element factory with the original one "
		e selectionOption elementFactory: previousSelectionFactory.
		e secondarySelectionOption elementFactory:
			previousSecondarySelectionFactory.
		previousSelectionFactory := nil.
		previousSecondarySelectionFactory := nil ]
]
