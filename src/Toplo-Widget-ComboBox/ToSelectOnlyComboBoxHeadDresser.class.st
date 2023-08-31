Class {
	#name : #ToSelectOnlyComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'headElementFactoryHandler',
		'crShortcut',
		'escShortcut',
		'upShortcut'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'events handling' }
ToSelectOnlyComboBoxHeadDresser >> leftMouseDownEvent: anEvent in: anElement [

	super leftMouseDownEvent: anEvent in: anElement.
	comboBox popupOrCloseEvent: anEvent.
	comboBox headElement requestFocus
]

{ #category : #deprecated }
ToSelectOnlyComboBoxHeadDresser >> leftPressed: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.
	comboBox popupOrCloseEvent: anEvent.
	comboBox headElement requestFocus
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> newDataElementFactory: aFactory in: anElement [

	| idx |
	anElement dataElementFactory: aFactory.
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

	downShortcut := self newArrowDownShortcutIn: anElement.
	upShortcut := self newArrowUpShortcutIn: anElement.

	crShortcut := BlShortcutWithAction new
		              combination: (BlKeyCombination primaryReturn or: BlKeyCombination return);
		              action: [
			              comboBox listElement primarySelectionIndexes ifNotEmpty: [
					              :idxes |
					              comboBox selectIndexInPresentedData: idxes first.
					              comboBox close ] ];
		              name: 'Accept';
		              yourself.
	escShortcut := BlShortcutWithAction new
		               combination: BlKeyCombination escape;
		               action: [ comboBox close ];
		               name: 'Escape';
		               yourself.

	anElement addShortcut: downShortcut.
	anElement addShortcut: upShortcut.
	anElement addShortcut: crShortcut.
	anElement addShortcut: escShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToSelectOnlyComboBoxHeadDresser >> whenRemovedFromParent: anElement [
	
	comboBox removeEventHandler: headElementFactoryHandler.
	anElement removeShortcut: crShortcut.
	anElement removeShortcut: escShortcut.
	anElement removeShortcut: downShortcut.
	anElement removeShortcut: upShortcut.
	super whenRemovedFromParent: anElement


]
