Class {
	#name : #ToSelectTextInputElement,
	#superclass : #ToElement,
	#instVars : [
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
	self fitContent
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

{ #category : #private }
ToSelectTextInputElement >> onFilterTextUpdated: anEvent [

	self fireEvent: ToSelectInputTextFieldUpdatedEvent new
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onInstalledIn: aNodeContainer [

	windowManager := aNodeContainer popupWindowManager.
	inputTextField := ToSelectTextField new.
	inputTextField headerNodeContainer: aNodeContainer.
	inputTextField withoutLineWrapping.
	inputTextField id: #inputTextField.
	self addChild: inputTextField.
	self selectFiltrable: aNodeContainer isFiltrable.
	self hFitContent.

	" Window handler open the window on text input.
	the window stays invisible until the sieve is applied to avoid inconfortable effect 
	(the window is first opened with unsieved content then the content is changed with sieve result).
	The window is set as visible in ToSelectListElement>>applyDataSourceSieveCommand: "
	windowPopupHandler := BlEventHandler
		                      on: BlTextInputEvent
		                      do: [ :event |
			                      event text ifNotEmpty: [
				                      event text asString first isAlphaNumeric
					                      ifTrue: [
					                      windowManager popupWindowHiddenEvent: event ] ] ].
	inputTextField infinite addEventHandler: windowPopupHandler
]

{ #category : #window }
ToSelectTextInputElement >> onPopupWindowClosed [

	self updateFocus
]

{ #category : #window }
ToSelectTextInputElement >> onPopupWindowOpened [		
		
	self updateFocus
]

{ #category : #'api - hooks' }
ToSelectTextInputElement >> onUninstalledIn: aNodeContainer [

	self uninstallInputTextFieldEventHandlers.
	inputTextField infinite removeEventHandler: windowPopupHandler.
	windowPopupHandler := nil.
	inputTextField := nil.
	self removeChildren
]

{ #category : #accessing }
ToSelectTextInputElement >> selectFiltrable: aBoolean [

	selectFiltrable := aBoolean.
	aBoolean
		ifTrue: [ self beEditable ]
		ifFalse: [ self beReadonly ].
]

{ #category : #initialization }
ToSelectTextInputElement >> uninstallInputTextFieldEventHandlers [

	installedInputTextFieldTextEventHandler ifNil: [ ^ self ].
	installedInputTextFieldTextEventHandler do: [ :h |
		self inputTextField removeEventHandler: h ].
	installedInputTextFieldTextEventHandler := nil
]

{ #category : #window }
ToSelectTextInputElement >> updateFocus [

	selectFiltrable
		ifTrue: [ self inputTextField requestFocus ]
		ifFalse: [ self parent requestFocus ]
]
