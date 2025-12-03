Class {
	#name : #ToTabFiniteListElementSkin,
	#superclass : #ToItemFiniteListElementSkin,
	#instVars : [
		'previousSelectionFactory',
		'previousSecondarySelectionFactory'
	],
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> installSelectionFactoriesIn: aTabBar [
	" keep the element factory to set them again on skin uninstalling "

	previousSelectionFactory := aTabBar selectionOption elementFactory.
	previousSecondarySelectionFactory := aTabBar secondarySelectionOption
		                                     elementFactory.
	" change the element factory with a specific placement and measurement "
	aTabBar selectionOption elementFactory: [
		ToTabFiniteListPrimarySelectionElement new ].
	aTabBar secondarySelectionOption elementFactory: [
		ToTabFiniteListSecondarySelectionElement new ]
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e border: BlBorder empty.
			e padding: BlInsets empty.
			" keep the element factory to set them again on skin uninstalling "
			self installSelectionFactoriesIn: e ]
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> uninstallSelectionFactoriesIn: aTabBar [
	" change the element factory with the original one "

	aTabBar selectionOption elementFactory: previousSelectionFactory.
	aTabBar secondarySelectionOption elementFactory:
		previousSecondarySelectionFactory.
	previousSelectionFactory := nil.
	previousSecondarySelectionFactory := nil
]

{ #category : #'event handling' }
ToTabFiniteListElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | " change the element factory with the original one "
		self uninstallSelectionFactoriesIn: e ]
]
