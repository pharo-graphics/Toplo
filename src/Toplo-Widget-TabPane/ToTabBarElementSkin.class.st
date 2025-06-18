Class {
	#name : #ToTabBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#instVars : [
		'previousSelectionFactory',
		'previousSecondarySelectionFactory'
	],
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #'event handling' }
ToTabBarElementSkin >> installSelectionFactoriesIn: aTabBar [
	" keep the element factory to set them again on skin uninstalling "

	previousSelectionFactory := aTabBar selectionOption elementFactory.
	previousSecondarySelectionFactory := aTabBar secondarySelectionOption
		                                     elementFactory.
	" change the element factory with a specific placement and measurement "
	aTabBar selectionOption elementFactory: [
		ToTabBarPrimarySelectionElement new ].
	aTabBar secondarySelectionOption elementFactory: [
		ToTabBarSecondarySelectionElement new ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: BlInsets empty.
		e border: BlBorder empty.
		" keep the element factory to set them again on skin uninstalling "
		self installSelectionFactoriesIn: e ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> uninstallSelectionFactoriesIn: aTabBar [
	" change the element factory with the original one "

	aTabBar selectionOption elementFactory: previousSelectionFactory.
	aTabBar secondarySelectionOption elementFactory:
		previousSecondarySelectionFactory.
	previousSelectionFactory := nil.
	previousSecondarySelectionFactory := nil
]

{ #category : #'event handling' }
ToTabBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | " change the element factory with the original one "
		self uninstallSelectionFactoriesIn: e ]
]
