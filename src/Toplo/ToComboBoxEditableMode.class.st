Class {
	#name : #ToComboBoxEditableMode,
	#superclass : #ToComboBoxMode,
	#instVars : [
		'listAutocomplete'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxEditableMode >> defaultHeadElementIn: aComboBox [

	^ ToEditableComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  in: [ :head | head saveAllowed: aComboBox saveAllowed ];
		  yourself
]

{ #category : #initialization }
ToComboBoxEditableMode >> initialize [ 

	super initialize.
	listAutocomplete := true
]

{ #category : #accessing }
ToComboBoxEditableMode >> listAutocomplete [

	^ listAutocomplete 
]

{ #category : #accessing }
ToComboBoxEditableMode >> listAutocomplete: aBoolean [

	listAutocomplete := aBoolean 
]
