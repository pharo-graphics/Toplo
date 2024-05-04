Class {
	#name : #ToSelectTextInputElement,
	#superclass : #ToElement,
	#instVars : [
		'selectedDataTextField',
		'inputTextField',
		'installedInputTextFieldTextEventHandler',
		'forFiltering',
		'forMultipleNodes'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSelectTextInputElement >> beEditable [

	self inputTextField beEditable.
	self installInputTextFieldEventHandlers
]

{ #category : #initialization }
ToSelectTextInputElement >> beReadonly [

	self uninstallInputTextFieldEventHandlers.
	self inputTextField beReadonlyWithoutSelection
]

{ #category : #private }
ToSelectTextInputElement >> checkMultipleSelectPlaceholderText [
	
]

{ #category : #private }
ToSelectTextInputElement >> checkSingleSelectPlaceholderText [
	" In case of single selection, the selectedDataTextField can contain 
	either the placeholder text or the selected data string"

	self inputTextField text
		ifEmpty: [
		self selectedDataTextField visibility: BlVisibility visible.
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
	self hMatchParent.
	self vFitContent
]

{ #category : #accessing }
ToSelectTextInputElement >> inputTextField [

	^ inputTextField
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
			 do: [ :event | self onFilterTextUpdated: event ]).
	installedInputTextFieldTextEventHandler do: [ :h |
		self inputTextField addEventHandler: h ]
]

{ #category : #testing }
ToSelectTextInputElement >> isForFiltering [

	^ forFiltering 
]

{ #category : #testing }
ToSelectTextInputElement >> isForMultipleNodes [

	^ forMultipleNodes 
]

{ #category : #initialization }
ToSelectTextInputElement >> newTextFieldIn: aHolder [

	| textField |
	textField := ToSelectTextField new.
	textField headerNodeContainer: aHolder.
	aHolder isSingleNode ifTrue: [
		textField withLineWrapping.
		textField hMatchParent ].
	^ textField
]

{ #category : #private }
ToSelectTextInputElement >> onFilterTextReplaced: anEvent [

	self fireEvent: ToSelectInputTextFieldUpdatedEvent new.
	self parent sieve pattern: self filterString.
	self parent isMultipleSelection
		ifTrue: [ self checkMultipleSelectPlaceholderText ]
		ifFalse: [ self checkSingleSelectPlaceholderText ]
]

{ #category : #private }
ToSelectTextInputElement >> onFilterTextUpdated: anEvent [

	self fireEvent: ToSelectInputTextFieldUpdatedEvent new.
	self inputTextField text
		ifEmpty: [
		self selectedDataTextField visibility: BlVisibility visible ]
		ifNotEmpty: [
		self selectedDataTextField visibility: BlVisibility hidden ]
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onInstalledIn: aNodeContainer [

	forMultipleNodes := aNodeContainer isSingleNode not.
	forFiltering := aNodeContainer elementBar isFiltrable.
	selectedDataTextField := self newTextFieldIn: aNodeContainer.
	selectedDataTextField beReadonlyWithSelection.
	inputTextField := self newTextFieldIn: aNodeContainer.
	selectedDataTextField id: #selectedDataTextField.
	inputTextField id: #inputTextField.
	self addChild: selectedDataTextField.
	self addChild: inputTextField.
	aNodeContainer elementBar isFiltrable
		ifTrue: [ self beEditable ]
		ifFalse: [ self beReadonly ].
	inputTextField addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | aNodeContainer elementBar windowManager popupWindowEvent: event ])
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onUninstalledIn: aNodeContainer [

	self removeChildren 
]

{ #category : #window }
ToSelectTextInputElement >> onWindowClosed [

	self isForMultipleNodes ifFalse: [
		self selectedDataTextField visibility: BlVisibility visible.
		self selectedDataTextField text foreground: Color black ].
	self isForFiltering ifTrue: [ self inputTextField requestFocus ]
]

{ #category : #window }
ToSelectTextInputElement >> onWindowOpened [

	self isForMultipleNodes ifFalse: [
		self selectedDataTextField text foreground: Color lightGray ].
	self isForFiltering
		ifTrue: [ self inputTextField requestFocus ]
		ifFalse: [ self parent requestFocus ]
]

{ #category : #accessing }
ToSelectTextInputElement >> selectedDataTextField [

	^ selectedDataTextField
]

{ #category : #initialization }
ToSelectTextInputElement >> uninstallInputTextFieldEventHandlers [

	installedInputTextFieldTextEventHandler ifNil: [ ^ self ].
	installedInputTextFieldTextEventHandler do: [ :h |
		self inputTextField removeEventHandler: h ].
	installedInputTextFieldTextEventHandler := nil
]
