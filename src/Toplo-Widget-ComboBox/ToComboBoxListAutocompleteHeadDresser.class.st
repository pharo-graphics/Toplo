Class {
	#name : 'ToComboBoxListAutocompleteHeadDresser',
	#superclass : 'Object',
	#instVars : [
		'comboBox',
		'filterDresser',
		'filterResultHandler'
	],
	#category : 'Toplo-Widget-ComboBox',
	#package : 'Toplo-Widget-ComboBox'
}

{ #category : 'accessing' }
ToComboBoxListAutocompleteHeadDresser >> comboBox: aComboBox [

	comboBox := aComboBox
]

{ #category : 'api - install/uninstall  hook' }
ToComboBoxListAutocompleteHeadDresser >> filterResult: anEvent [

	comboBox listElement deselectAll.
	comboBox presentedData filterResult: anEvent data.
	comboBox fitListElementToContent
]

{ #category : 'api - install/uninstall  hook' }
ToComboBoxListAutocompleteHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	filterDresser := ToListElementFilter new.
	filterDresser filter: [ :data :pattern | (anElement dataToTextConverter value: data) beginsWith: pattern caseSensitive: true ].
	filterDresser originalDataProvider: [ comboBox data asArray sorted ].
	comboBox listElement addDresser: filterDresser.
	anElement textField whenTextEditedDo: [ :event | self textUpdatedIn: anElement ].
	filterResultHandler := BlEventHandler on: ToDataFilterResultEvent do: [ :event | self filterResult: event ].
	comboBox listElement addEventHandler: filterResultHandler.


]

{ #category : 'api - install/uninstall  hook' }
ToComboBoxListAutocompleteHeadDresser >> textUpdatedIn: anElement [

	comboBox listElement dispatchEvent: (ToDataFilterRequest new pattern: anElement textField text asString)
]

{ #category : 'api - install/uninstall  hook' }
ToComboBoxListAutocompleteHeadDresser >> uninstallEventListenersIn: anElement [

	comboBox listElement removeDresser: filterDresser.
	comboBox listElement removeEventHandler: filterResultHandler.
	filterDresser := nil.
	filterResultHandler := nil.

	super uninstallEventListenersIn: anElement
]
