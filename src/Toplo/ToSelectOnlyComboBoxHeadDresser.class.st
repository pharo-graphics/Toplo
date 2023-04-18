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
	self selectedIndex: comboBox selectedIndex in: anElement.
	(idx := comboBox selectedIndex) isZero ifFalse: [
		comboBox listElement selectIndex: idx ]
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> whenAddedToParent: anElement [

	super 	whenAddedToParent: anElement.

	headElementFactoryHandler := BlEventHandler 
												on: ToComboBoxHeadElementFactoryChangeEvent 
												do: [ :event | self newDataElementFactory: event factory in: anElement].
	comboBox addEventHandler: headElementFactoryHandler.

	downShortcut := BlShortcutWithAction new
			 combination: BlKeyCombination arrowDown ;
			 action: [ :event | comboBox popupEvent: event ];
			 name: 'Popup';
			 yourself.
	anElement addShortcut: downShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> whenRemovedFromParent: anElement [
	
	comboBox removeEventHandler: headElementFactoryHandler.
	comboBox removeShortcut: downShortcut.

	
	super whenRemovedFromParent: anElement


]
