Class {
	#name : #ToInlineAutocompleteComboBoxHeadDresser,
	#superclass : #ToDataEditingComboBoxHeadDresser,
	#instVars : [
		'filterDresser',
		'filterResultHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToInlineAutocompleteComboBoxHeadDresser >> filterResult: anEvent [

	comboBox listElement data filterResult: anEvent data.
	comboBox fitListElementToContent.
	comboBox popupEvent: anEvent.
	anEvent data size = 1 ifTrue: [  comboBox selectIndex: 1 ]
]

{ #category : #'api - install/uninstall  hook' }
ToInlineAutocompleteComboBoxHeadDresser >> selectedIndex: anIndex in: anElement [

	super selectedIndex: anIndex in: anElement.
	anIndex isZero ifTrue: [ ^ self ].
	comboBox listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: anElement textField text asString)
]

{ #category : #'api - install/uninstall  hook' }
ToInlineAutocompleteComboBoxHeadDresser >> textUpdatedIn: anElement [

	comboBox listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: anElement textField text asString)
]

{ #category : #'api - install/uninstall  hook' }
ToInlineAutocompleteComboBoxHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	filterDresser := ToDataFilterDresser new filter: [ :data :pattern |
		                 (anElement dataToTextConverter value: data)
			                 beginsWith: pattern
			                 caseSensitive: false ].
	comboBox listElement addDresser: filterDresser.
	anElement textField whenTextEditedDo: [ :event | self textUpdatedIn: anElement ].
	filterResultHandler := BlEventHandler
		                       on: ToDataFilterResultEvent
		                       do: [ :event | self filterResult: event ].
	comboBox listElement addEventHandler: filterResultHandler
]

{ #category : #'api - install/uninstall  hook' }
ToInlineAutocompleteComboBoxHeadDresser >> whenRemoved: anElement [

	comboBox listElement removeDresser: filterDresser.
	comboBox listElement removeEventHandler: filterResultHandler.
	filterDresser := nil.
	filterResultHandler := nil.
	super whenRemoved: anElement
]
