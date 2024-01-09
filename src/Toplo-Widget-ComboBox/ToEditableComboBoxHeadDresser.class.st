Class {
	#name : #ToEditableComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'escShortcut',
		'upShortcut',
		'mouseDownOnButtonHandler',
		'crShortcut',
		'saveRequestedHandler',
		'cancelRequestedHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> cancelRequestedInTextField: aCancelRequestedEvent [

	comboBox close.
	comboBox dispatchEvent: aCancelRequestedEvent

]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> carriageReturnEvent: anEvent in: anElement [

	^ self selectIndexInPresentedData
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newButtonMouseDownHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseDownEvent
		  do: [ :evt | comboBox popupOrCloseEvent: evt]
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
ToEditableComboBoxHeadDresser >> saveRequestedInTextField: aSaveRequestedEvent [

	self selectIndexInPresentedData.
	comboBox dispatchEvent: aSaveRequestedEvent

]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> selectIndexInPresentedData [

	comboBox isOpened ifFalse: [ ^ self ].
	comboBox listElement selection selectedIndexes ifNotEmpty: [ :idxes |
		comboBox selectIndexInPresentedData: idxes first.
		comboBox close ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> textUpdatedIn: anElement [

	comboBox listElement dispatchEvent: (ToDataFilterRequest new pattern: anElement textField text asString)
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenAddedToParent: anElement [

	super whenAddedToParent: anElement.

	mouseDownOnButtonHandler := self newButtonMouseDownHandlerIn: anElement.
	anElement second addEventHandler: mouseDownOnButtonHandler.

	saveRequestedHandler := BlEventHandler
		                        on: ToAlbumSaveRequestedEvent
		                        do: [ :saveRequested | self saveRequestedInTextField: saveRequested ].
	cancelRequestedHandler := BlEventHandler
		                        on: ToAlbumCancelRequestedEvent
		                        do: [ :cancelRequested | self cancelRequestedInTextField: cancelRequested ].

	downShortcut := self newArrowDownShortcutIn: anElement.
	upShortcut := self newArrowUpShortcutIn: anElement.
	escShortcut := self newEscapeShortcutIn: anElement.
	crShortcut := self newCarriageReturnShortcutIn: anElement.

	anElement textField addEventHandler: saveRequestedHandler.
	anElement textField addEventHandler: cancelRequestedHandler.
	anElement textField addEditorShortcut: downShortcut.
	anElement textField addEditorShortcut: upShortcut.
	anElement textField addEditorShortcut: escShortcut.
	anElement textField addEditorShortcut: crShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenRemovedFromParent: anElement [

	anElement textField removeEventHandler: saveRequestedHandler.
	anElement textField removeEditorShortcut: downShortcut.
	anElement textField removeEditorShortcut: upShortcut.
	anElement textField removeEditorShortcut: escShortcut.
	anElement textField removeEditorShortcut: crShortcut.
	anElement second removeEventHandler: mouseDownOnButtonHandler.

	super whenRemovedFromParent: anElement
]
