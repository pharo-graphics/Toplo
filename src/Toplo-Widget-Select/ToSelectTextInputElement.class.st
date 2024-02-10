Class {
	#name : #ToSelectTextInputElement,
	#superclass : #ToElement,
	#instVars : [
		'select',
		'selectedDataTextField',
		'inputTextField'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectTextInputElement >> beReadonly [

	self inputTextField beReadonlyWithoutSelection
]

{ #category : #private }
ToSelectTextInputElement >> checkMultipleSelectPlaceholderText [
	" In case of multiple selection, the selectedDataTextField can contain 
		and empty text or the placeholder text"

	(self inputTextField text isEmpty and: [ select selectedData isEmpty ])
		ifTrue: [
			self selectedDataTextField visibility: BlVisibility visible.
			self selectedDataTextField text: select placeholderText.
			^ self ].
	self selectedDataTextField visibility: BlVisibility hidden.
	self selectedDataTextField text: ''
]

{ #category : #private }
ToSelectTextInputElement >> checkSingleSelectPlaceholderText [
	" In case of single selection, the selectedDataTextField can contain 
	either the placeholder text or the selected data string"

	self inputTextField text
		ifEmpty: [
		self selectedDataTextField text foreground: Color lightGray ]
		ifNotEmpty: [
		self selectedDataTextField visibility: BlVisibility hidden ]
]

{ #category : #accessing }
ToSelectTextInputElement >> filterString [

	^ self inputTextField text asString
]

{ #category : #initialization }
ToSelectTextInputElement >> initialize [ 

	super initialize.
	self id: #textInputElement.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c frame vertical alignCenter.
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	self background: BlBackground transparent.
	self fitContent
]

{ #category : #accessing }
ToSelectTextInputElement >> inputTextField [

	^ inputTextField
]

{ #category : #initialization }
ToSelectTextInputElement >> newInputTextField [

	| textField |
	textField := self newTextField
		             id: #inputTextField;
		             yourself.		
	textField fitContent.
	select isFiltrable
		ifTrue: [
			select isMultipleSelection ifTrue: [
				textField addEditorShortcut:
					ToSelectTextFieldBackspaceShortcut new ].
			textField addEditorShortcut:
				ToSelectTextFieldCarriageReturnShortcut new.
			textField addEventHandler: (BlEventHandler
					 on: AlbTextEditedEvent
					 do: [ :event |  self onFilterTextFieldUpdated: event ]).
			textField addEventHandler: (BlEventHandler
					 on: AlbTextReplacedEvent
					 do: [ :event |  self onFilterTextFieldUpdated: event ]) ]
		ifFalse: [ textField beReadonlyWithSelection ].
	
	^ textField
]

{ #category : #initialization }
ToSelectTextInputElement >> newTextField [ 

	| textField |
	textField := ToSelectTextField new
		             select: select;
		             yourself.
	^ textField
]

{ #category : #private }
ToSelectTextInputElement >> onFilterTextFieldUpdated: anEvent [

	select mode pattern: self filterString.
	select isMultipleSelection
		ifTrue: [self checkMultipleSelectPlaceholderText ]
		ifFalse: [self checkSingleSelectPlaceholderText]
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onInstalledIn: aSelect [

	select := aSelect.
	selectedDataTextField := self newTextField.
	selectedDataTextField beReadonlyWithSelection.
	selectedDataTextField fitContent.
	selectedDataTextField text: select placeholderText.
	inputTextField := self newInputTextField.
	inputTextField fitContent.
	aSelect isMultipleSelection ifFalse: [
		self hMatchParent.
		inputTextField withLineWrapping.
		selectedDataTextField withLineWrapping.
		inputTextField hMatchParent.
		selectedDataTextField hMatchParent ].
	aSelect isFiltrable ifFalse: [ inputTextField beReadonlyWithoutSelection ].
	" the id is set here to avoid that a fake node with a text field with the same id "
	selectedDataTextField id: #selectedDataTextField.
	self addChild: selectedDataTextField.
	self addChild: inputTextField
]

{ #category : #private }
ToSelectTextInputElement >> onMultipleSelectDataNodeListChanged [

	self checkMultipleSelectPlaceholderText
]

{ #category : #placeholder }
ToSelectTextInputElement >> onSelectPlaceholderTextChanged [

	(self selectedDataTextField notNil and: [
		 select selectedData isEmpty ]) ifTrue: [
		self selectedDataTextField text: select placeholderText ]
]

{ #category : #private }
ToSelectTextInputElement >> onSingleSelectDataChanged [

	self inputTextField text: ''.
	select selectedData
		ifEmpty: [ self selectedDataTextField text: select placeholderText ]
		ifNotEmpty: [ :l | self selectedDataTextField text: l first asString ]
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onUninstalledIn: aSelect [

	select := nil.
	self removeChildren 
]

{ #category : #window }
ToSelectTextInputElement >> onWindowClosed [

	select isMultipleSelection ifFalse: [
		self selectedDataTextField visibility: BlVisibility visible.
		self selectedDataTextField text foreground: Color black ].
	select isFiltrable ifTrue: [ self inputTextField requestFocus ]
]

{ #category : #window }
ToSelectTextInputElement >> onWindowOpened [

	select isMultipleSelection ifFalse: [
		self selectedDataTextField text foreground: Color lightGray ].
	select isFiltrable ifTrue: [ self inputTextField requestFocus ]
]

{ #category : #accessing }
ToSelectTextInputElement >> select [

	^ select
]

{ #category : #accessing }
ToSelectTextInputElement >> selectedDataTextField [

	^ selectedDataTextField
]
