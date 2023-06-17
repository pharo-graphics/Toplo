Class {
	#name : #ToComboBoxEditableMode,
	#superclass : #ToComboBoxMode,
	#instVars : [
		'inlineAutocomplete'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxEditableMode >> defaultHeadElementIn: aComboBox [

	^ (inlineAutocomplete
		   ifTrue: [ ToInlineAutocompleteComboBoxHead new ]
		   ifFalse: [ ToEditableComboBoxHead new ])
		  vFitContent;
		  hMatchParent;
		  in: [ :head | head saveAllowed: aComboBox saveAllowed ];
		  yourself
]

{ #category : #initialization }
ToComboBoxEditableMode >> initialize [ 

	super initialize.
	inlineAutocomplete := true
]

{ #category : #accessing }
ToComboBoxEditableMode >> inlineAutocomplete [

	^ inlineAutocomplete 
]

{ #category : #accessing }
ToComboBoxEditableMode >> inlineAutocomplete: aBoolean [

	inlineAutocomplete := aBoolean 
]
