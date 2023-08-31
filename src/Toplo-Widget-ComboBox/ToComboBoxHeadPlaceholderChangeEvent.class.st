Class {
	#name : #ToComboBoxHeadPlaceholderChangeEvent,
	#superclass : #ToComboBoxEvent,
	#instVars : [
		'placeholder'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHeadPlaceholderChangeEvent >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToComboBoxHeadPlaceholderChangeEvent >> placeholder: anElement [

	placeholder := anElement
]
