Class {
	#name : #ToSelectTextInput,
	#superclass : #ToElement,
	#instVars : [
		'select',
		'selectedDataTextField',
		'inputTextField'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectTextInput >> initialize [ 

	super initialize.
	self id: #textInput.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c frame vertical alignCenter.
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	self background: BlBackground transparent.
	self fitContent
]

{ #category : #accessing }
ToSelectTextInput >> inputTextField [

	^ inputTextField
]

{ #category : #'api - hooks' }
ToSelectTextInput >> onInstalledIn: aSelect [
	
	select := aSelect.
	selectedDataTextField := select mode newTextField.
	selectedDataTextField text: select placeholderText.
	selectedDataTextField beReadonlyWithSelection.
	selectedDataTextField fitContent.
	selectedDataTextField text: select placeholderText.
	inputTextField := select mode newInputTextField.
	inputTextField fitContent.
	aSelect isMultiSelection ifFalse: [ 
		self hMatchParent.
		inputTextField withLineWrapping.
		selectedDataTextField withLineWrapping.
		inputTextField hMatchParent. 
		selectedDataTextField hMatchParent ].
	" the id is set here to avoid that a fake node with a text field with the same id "
	selectedDataTextField id: #selectedDataTextField.
	self addChild: selectedDataTextField.
	self addChild: inputTextField
]

{ #category : #'api - hooks' }
ToSelectTextInput >> onUninstalledIn: aSelect [
	
	select := nil.
	self removeChildren 
]

{ #category : #accessing }
ToSelectTextInput >> select [

	^ select
]

{ #category : #accessing }
ToSelectTextInput >> selectedDataTextField [

	^ selectedDataTextField
]
