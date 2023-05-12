Class {
	#name : #ToComboBoxDataEditingMode,
	#superclass : #ToComboBoxEditableMode,
	#instVars : [
		'inlineAutocomplete'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxDataEditingMode >> defaultHeadElement [

	^ (inlineAutocomplete
		   ifTrue: [ ToInlineAutocompleteComboBoxHead new ]
		   ifFalse: [ ToDataEditingComboBoxHead new ])
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #initialization }
ToComboBoxDataEditingMode >> initialize [ 

	super initialize.
	inlineAutocomplete := true
]

{ #category : #accessing }
ToComboBoxDataEditingMode >> inlineAutocomplete [

	^ inlineAutocomplete 
]

{ #category : #accessing }
ToComboBoxDataEditingMode >> inlineAutocomplete: aBoolean [

	inlineAutocomplete := aBoolean 
]
