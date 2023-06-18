Class {
	#name : #ToAutocompleteComboBoxHeadDresser,
	#superclass : #ToEditableComboBoxHeadDresser,
	#instVars : [
		'filterDresser',
		'filterResultHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToAutocompleteComboBoxHeadDresser >> filterResult: anEvent [

	comboBox presentedData filterResult: anEvent data.
	comboBox fitListElementToContent
]

{ #category : #'api - install/uninstall  hook' }
ToAutocompleteComboBoxHeadDresser >> textUpdatedIn: anElement [

	comboBox listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: anElement textField text asString)
]

{ #category : #'api - install/uninstall  hook' }
ToAutocompleteComboBoxHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	filterDresser := ToDataFilterDresser new 
							filter: [ :data :pattern |
		                 (anElement dataToTextConverter value: data)
			                 beginsWith: pattern
			                 caseSensitive: false ];
							originalDataProvider: [ comboBox data asArray sorted].
	comboBox listElement addDresser: filterDresser.
	anElement textField whenTextEditedDo: [ :event | self textUpdatedIn: anElement ].
	filterResultHandler := BlEventHandler
		                       on: ToDataFilterResultEvent
		                       do: [ :event | self filterResult: event ].
	comboBox listElement addEventHandler: filterResultHandler
]

{ #category : #'api - install/uninstall  hook' }
ToAutocompleteComboBoxHeadDresser >> whenRemoved: anElement [

	comboBox listElement removeDresser: filterDresser.
	comboBox listElement removeEventHandler: filterResultHandler.
	filterDresser := nil.
	filterResultHandler := nil.
	super whenRemoved: anElement
]
