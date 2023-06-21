Class {
	#name : #ToEditableComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'escShortcut',
		'upShortcut',
		'mouseDownOnButtonHandler',
		'crShortcut'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> carriageReturnEvent: anEvent in: anElement [

	comboBox isOpened ifFalse: [ ^ self ].
	comboBox listElement primarySelectionIndexes ifNotEmpty: [ :idxes |
		comboBox selectIndexInPresentedData: idxes first.
		comboBox close ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newButtonMouseDownHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseDownEvent
		  do: [ :evt | comboBox popupOrCloseEvent: evt ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newCarriageReturnShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination return;
		                action: [ :event | self carriageReturnEvent: event in: anElement ];
		                name: 'Return';
		                yourself.
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newListClosedHandlerIn: anElement [

	^ BlEventHandler
		  on: ToWidgetWindowClosedEvent
		  do: [ :event | anElement textField requestFocus ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> textUpdatedIn: anElement [

	comboBox listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: anElement textField text asString)
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.

	mouseDownOnButtonHandler := self newButtonMouseDownHandlerIn: anElement.
	anElement second addEventHandler: mouseDownOnButtonHandler.

	downShortcut := self newArrowDownShortcutIn: anElement.
	upShortcut := self newArrowUpShortcutIn: anElement.
	escShortcut := self newEscapeShortcutIn: anElement.
	crShortcut := self newCarriageReturnShortcutIn: anElement.
	
	anElement textField addEditorShortcut: downShortcut.
	anElement textField addEditorShortcut: upShortcut.	
	anElement textField addEditorShortcut: escShortcut.
	anElement textField addEditorShortcut: crShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenRemoved: anElement [

	anElement textField removeEditorShortcut: downShortcut.
	anElement textField removeEditorShortcut: upShortcut.
	anElement textField removeEditorShortcut: escShortcut.
	anElement textField removeEditorShortcut: crShortcut.
	anElement second removeEventHandler: mouseDownOnButtonHandler.

	super whenRemoved: anElement
]
