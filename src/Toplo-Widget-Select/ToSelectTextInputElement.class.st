Class {
	#name : #ToSelectTextInputElement,
	#superclass : #ToElement,
	#instVars : [
		'selectedDataTextField',
		'inputTextField',
		'installedInputTextFieldTextEventHandler',
		'windowPopupHandler',
		'selectFiltrable',
		'windowManager'
	],
	#category : #'Toplo-Widget-Select-textInput'
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
ToSelectTextInputElement >> checkPlaceholderText [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectTextInputElement >> configureTextField: aTextField [

	self subclassResponsibility 
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

{ #category : #initialization }
ToSelectTextInputElement >> newTextFieldIn: aNodeContainer [

	| textField |
	textField := ToSelectTextField new.
	textField headerNodeContainer: aNodeContainer.
	self configureTextField: textField.
	^ textField
]

{ #category : #private }
ToSelectTextInputElement >> onFilterTextReplaced: anEvent [

	self fireEvent: ToSelectInputTextFieldUpdatedEvent new.
	self parent sieve pattern: self filterString.
	self checkPlaceholderText
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

	selectFiltrable := aNodeContainer isFiltrable.
	windowManager := aNodeContainer windowManager.
	selectedDataTextField := self newTextFieldIn: aNodeContainer.
	selectedDataTextField beReadonlyWithSelection.
	selectedDataTextField id: #selectedDataTextField.
	inputTextField := self newTextFieldIn: aNodeContainer.
	inputTextField id: #inputTextField.
	self addChild: selectedDataTextField.
	self addChild: inputTextField.
	aNodeContainer isFiltrable
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
					                 windowManager
						                 popupWindowHiddenEvent: event ] ] ].
	inputTextField infinite addEventHandler: windowPopupHandler
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onUninstalledIn: aNodeContainer [

	self uninstallInputTextFieldEventHandlers.
	inputTextField infinite removeEventHandler: windowPopupHandler.
	windowPopupHandler := nil.
	selectedDataTextField := nil.
	inputTextField := nil.
	self removeChildren
]

{ #category : #window }
ToSelectTextInputElement >> onWindowClosed [

	"self selectedDataTextField visibility: BlVisibility visible.
	self selectedDataTextField text foreground: Color black.
	selectFiltrable ifTrue: [ self inputTextField requestFocus ]"
]

{ #category : #window }
ToSelectTextInputElement >> onWindowOpened [		
		
	"self selectedDataTextField text foreground: Color lightGray.
	selectFiltrable
		ifTrue: [ self inputTextField requestFocus ]
		ifFalse: [ self parent requestFocus ]"
]

{ #category : #accessing }
ToSelectTextInputElement >> selectFiltrable: aBoolean [

	selectFiltrable := aBoolean.
	aBoolean
		ifTrue: [ self beEditable ]
		ifFalse: [ self beReadonly ].
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
