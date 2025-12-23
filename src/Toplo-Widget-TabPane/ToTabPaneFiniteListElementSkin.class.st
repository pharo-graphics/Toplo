Class {
	#name : #ToTabPaneFiniteListElementSkin,
	#superclass : #ToTabFiniteListElementSkin,
	#instVars : [
		'previousSelectionFactory',
		'previousSecondarySelectionFactory'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabPaneFiniteListElementSkin >> installSelectionFactoriesIn: aTabBar [
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
ToTabPaneFiniteListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: BlRectangleGeometry new.
			" keep the element factory to set them again on skin uninstalling "
			self installSelectionFactoriesIn: e ]
]

{ #category : #'event handling' }
ToTabPaneFiniteListElementSkin >> uninstallSelectionFactoriesIn: aTabBar [
	" change the element factory with the original one "

	aTabBar selectionOption elementFactory: previousSelectionFactory.
	aTabBar secondarySelectionOption elementFactory:
		previousSecondarySelectionFactory.
	previousSelectionFactory := nil.
	previousSecondarySelectionFactory := nil
]
