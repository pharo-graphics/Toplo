Class {
	#name : #ToEditableComboBoxHeadDresser,
	#superclass : #ToComboBoxHeadDresser,
	#instVars : [
		'escShortcut',
		'upShortcut',
		'mouseDownOnButtonHandler',
		'filterDresser',
		'filterResultHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> filterResult: anEvent [

	comboBox presentedData filterResult: anEvent data.
	comboBox fitListElementToContent
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newListClosedHandlerIn: anElement [

	^ BlEventHandler
		  on: ToWidgetWindowClosedEvent
		  do: [ :event | anElement textField requestFocus ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> newMouseDownHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseDownEvent
		  do: [ :evt |
			  comboBox popupOrCloseEvent: evt.
			  evt target = anElement textField ifFalse: [
				  self listElementRequestFocus ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> textUpdatedIn: anElement [

	comboBox listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: anElement textField text asString)
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.

	comboBox isListAutocomplete ifTrue: [  
		filterDresser := ToDataFilterDresser new.
		filterDresser filter: [ :data :pattern | (anElement dataToTextConverter value: data) beginsWith: pattern caseSensitive: false ].
		filterDresser originalDataProvider: [ comboBox data asArray sorted].
		comboBox listElement addDresser: filterDresser.
		anElement textField whenTextEditedDo: [ :event | self textUpdatedIn: anElement ].
		filterResultHandler := BlEventHandler on: ToDataFilterResultEvent do: [ :event | self filterResult: event ].
		comboBox listElement addEventHandler: filterResultHandler ].

	mouseDownOnButtonHandler := self newMouseDownHandlerIn: anElement.
	anElement second addEventHandler: mouseDownOnButtonHandler.

	anElement textField whenSaveRequestedDo: [ :saveRequested |
		anElement whenSaveRequested: saveRequested in: comboBox ].

	anElement textField whenCancelRequestedDo: [ :cancelRequested |
		anElement whenCancelRequested: cancelRequested in: comboBox ].

	downShortcut := self newArrowDownShortcutIn: anElement.
	upShortcut := self newArrowUpShortcutIn: anElement.
	escShortcut := self newEscapeShortcutIn: anElement.
	anElement textField infinite addShortcut: downShortcut.
	anElement textField infinite addShortcut: upShortcut.	
	anElement textField infinite addShortcut: escShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToEditableComboBoxHeadDresser >> whenRemoved: anElement [

	filterDresser ifNotNil: [
		comboBox listElement removeDresser: filterDresser.
		comboBox listElement removeEventHandler: filterResultHandler.
		filterDresser := nil.
		filterResultHandler := nil ].

	anElement textField infinite removeShortcut: downShortcut.
	anElement textField infinite removeShortcut: upShortcut.
	anElement textField infinite removeShortcut: escShortcut.
	anElement second removeEventHandler: mouseDownOnButtonHandler.

	super whenRemoved: anElement
]
