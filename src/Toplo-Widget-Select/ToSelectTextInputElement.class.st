Class {
	#name : #ToSelectTextInputElement,
	#superclass : #ToElement,
	#instVars : [
		'selectedDataTextField',
		'inputTextField',
		'installedInputTextFieldTextEventHandler',
		'forFiltering',
		'forMultipleNodes',
		'windowPopupHandler'
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
ToSelectTextInputElement >> newTextFieldIn: aNodeContainer [

	| textField |
	textField := ToSelectTextField new.
	textField headerNodeContainer: aNodeContainer.
	aNodeContainer isSingleNode ifTrue: [
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

	" Window handler open the window on text input.
	the window stays invisible until the sieve is applied to avoid inconfortable effect 
	(the window is first opened with unsieved content then the content is changed with sieve result).
	The window is set as visible in ToSelectListElement>>applyDataSourceSieveCommand: "
	windowPopupHandler := BlEventHandler
		                 on: BlTextInputEvent
		                 do: [ :event |
			                 event text ifNotEmpty: [
				                 event text asString first isAlphaNumeric ifTrue: [
					                 aNodeContainer elementBar windowManager
						                 popupWindowHiddenEvent: event ] ] ].
	inputTextField infinite addEventHandler: windowPopupHandler
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onUninstalledIn: aNodeContainer [

	self uninstallInputTextFieldEventHandlers.
	inputTextField infinite removeEventHandler: windowPopupHandler.
	windowPopupHandler := nil.
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
