Class {
	#name : #ToSelectOnlyComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'headElementFactoryHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'events handling' }
ToSelectOnlyComboBoxHeadDresser >> leftPressed: anElement event: anEvent [

	comboBox ifNil: [ ^ self ].
	comboBox popupOrCloseEvent: anEvent.
	self listElementRequestFocus
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> newDataElementFactory: aFactory in: anElement [

	| idx |
	anElement dataElementFactory: aFactory.
	(idx := comboBox selectedIndex) isZero ifFalse: [
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
