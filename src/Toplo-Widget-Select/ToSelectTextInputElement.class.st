Class {
	#name : #ToSelectTextInputElement,
	#superclass : #ToElement,
	#instVars : [
		'select',
		'selectedDataTextField',
		'inputTextField',
		'installedInputTextFieldShortcuts',
		'installedInputTextFieldTextEventHandler'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectTextInputElement >> beEditable [

	self inputTextField beEditable.
	self installInputTextFieldEventHandlers.
	self installInputTestFieldShortcuts.

]

{ #category : #initialization }
ToSelectTextInputElement >> beReadonly [

	self uninstallInputTextFieldEventHandlers.
	self uninstallInputTestFieldShortcuts.
	self inputTextField beReadonlyWithoutSelection
]

{ #category : #private }
ToSelectTextInputElement >> checkMultipleSelectPlaceholderText [
	" In case of multiple selection, the selectedDataTextField can contain 
		and empty text or the placeholder text"

"	(self inputTextField text isEmpty and: [ select selectedData isEmpty ])
		ifTrue: [
			self selectedDataTextField visibility: BlVisibility visible.
			^ self ].
	""self selectedDataTextField visibility: BlVisibility hidden."""
]

{ #category : #private }
ToSelectTextInputElement >> checkSingleSelectPlaceholderText [
	" In case of single selection, the selectedDataTextField can contain 
	either the placeholder text or the selected data string"

	self inputTextField text
		ifEmpty: [
		self selectedDataTextField visibility: BlVisibility visible.
		"self selectedDataTextField text foreground: Color lightGray" ]
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
	self hMatchParent.
	self vFitContent
]

{ #category : #accessing }
ToSelectTextInputElement >> inputTextField [

	^ inputTextField
]

{ #category : #initialization }
ToSelectTextInputElement >> installInputTestFieldShortcuts [

	installedInputTextFieldShortcuts ifNotNil: [ ^ self ].
	installedInputTextFieldShortcuts := OrderedCollection new.

	select isMultipleSelection ifTrue: [
		installedInputTextFieldShortcuts add: ToSelectTextFieldBackspaceShortcut new ].
	installedInputTextFieldShortcuts add: ToSelectTextFieldCarriageReturnShortcut new.
	installedInputTextFieldShortcuts do: [ :sc |
		self inputTextField addEditorShortcut: sc ]
]

{ #category : #initialization }
ToSelectTextInputElement >> installInputTextFieldEventHandlers [

	installedInputTextFieldTextEventHandler ifNotNil: [ ^ self ].
	installedInputTextFieldTextEventHandler := OrderedCollection new.
	installedInputTextFieldTextEventHandler add: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [ :event | self onFilterTextUpdated: event ]).
	installedInputTextFieldTextEventHandler add: (BlEventHandler
			 on: AlbTextReplacedEvent
			 do: [ :event | self onFilterTextReplaced: event ]).
	installedInputTextFieldTextEventHandler do: [ :h |
		self inputTextField addEventHandler: h ]
]

{ #category : #initialization }
ToSelectTextInputElement >> newTextField [ 

	| textField |
	textField := ToSelectTextField new
		             select: select;
		             yourself.
	select isSingleSelection ifTrue: [
		textField withLineWrapping.
		textField hMatchParent].
	^ textField
]

{ #category : #private }
ToSelectTextInputElement >> onFilterTextReplaced: anEvent [

	select pattern: self filterString.
	select isMultipleSelection
		ifTrue: [ self checkMultipleSelectPlaceholderText ]
		ifFalse: [ self checkSingleSelectPlaceholderText ]
]

{ #category : #private }
ToSelectTextInputElement >> onFilterTextUpdated: anEvent [

	select pattern: self filterString.
	select isMultipleSelection
		ifTrue: [ self checkMultipleSelectPlaceholderText ]
		ifFalse: [ self checkSingleSelectPlaceholderText ]
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onInstalledIn: aSelect [

	select := aSelect.
	selectedDataTextField := self newTextField.
	selectedDataTextField beReadonlyWithSelection.
"	selectedDataTextField
		hMatchParent;
		vFitContent."
	inputTextField := self newTextField.
	selectedDataTextField id: #selectedDataTextField.
	inputTextField id: #inputTextField.
	self addChild: selectedDataTextField.
	self addChild: inputTextField.
	select isFiltrable
		ifTrue: [ self beEditable ]
		ifFalse: [ self beReadonly ].
	inputTextField addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | self select windowManager popupWindowEvent: event ])
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

{ #category : #initialization }
ToSelectTextInputElement >> uninstallInputTestFieldShortcuts [

	installedInputTextFieldShortcuts ifNil: [ ^ self ].
	installedInputTextFieldShortcuts do: [ :sc |
		self inputTextField removeEditorShortcut: sc ].
	installedInputTextFieldShortcuts := nil
]

{ #category : #initialization }
ToSelectTextInputElement >> uninstallInputTextFieldEventHandlers [

	installedInputTextFieldTextEventHandler ifNil: [ ^ self ].
	installedInputTextFieldTextEventHandler do: [ :h |
		self inputTextField removeEventHandler: h ].
	installedInputTextFieldTextEventHandler := nil
]
