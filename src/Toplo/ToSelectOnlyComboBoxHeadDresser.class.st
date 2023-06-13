Class {
	#name : #ToSelectOnlyComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'headElementFactoryHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> newDataElementFactory: aFactory in: anElement [

	| idx |
	anElement dataElementFactory: aFactory.
	self selectedIndex: comboBox selectedIndexInPresentedData in: anElement.
	(idx := comboBox selectedIndexInPresentedData) isZero ifFalse: [
		comboBox listElement selectIndex: idx ]
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> whenAdded: anElement [

	super 	whenAdded: anElement.

	headElementFactoryHandler := BlEventHandler 
												on: ToComboBoxHeadElementFactoryChangeEvent 
												do: [ :event | self newDataElementFactory: event factory in: anElement].
	comboBox addEventHandler: headElementFactoryHandler.

	downShortcut := self newArrowDownShortcutIn: anElement.
	anElement addShortcut: downShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> whenRemoved: anElement [
	
	comboBox removeEventHandler: headElementFactoryHandler.
	comboBox removeShortcut: downShortcut.

	
	super whenRemoved: anElement


]
