Class {
	#name : #ToSelectFilterTextField,
	#superclass : #ToTextField,
	#instVars : [
		'windowPopupHandler',
		'selectInnerContainer',
		'installedEventHandler'
	],
	#category : #'Toplo-Widget-Select-textInput'
}

{ #category : #initialization }
ToSelectFilterTextField >> initialize [

	super initialize.
	self id: #filterTextField.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c frame vertical alignCenter.
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	self fitContent.
	self withSaveCapability.
	self withoutEditsFeedback.

]

{ #category : #skin }
ToSelectFilterTextField >> newRawSkin [ 

	^ ToSelectFilterTextFieldSkin new
]

{ #category : #enumerating }
ToSelectFilterTextField >> nodeBeforeDo: aBlock [

	self selectNodeBefore ifNotNil: [ :n | aBlock value: n ]
]

{ #category : #'api - hooks' }
ToSelectFilterTextField >> onInstalledIn: aSelectElement [

	selectInnerContainer := aSelectElement innerContainer.
	self withoutLineWrapping.
	self id: #filterTextField.
	self selectFiltrable: aSelectElement isFiltrable.
	installedEventHandler := {
		                         (BlEventHandler
			                          on: AlbTextEditedEvent
			                          do: [ :event |
			                          aSelectElement filterStringChanged ]).
		                         (BlEventHandler
			                          on: AlbTextReplacedEvent
			                          do: [ :event |
			                          aSelectElement filterStringChanged ]) }.
	installedEventHandler do: [ :h | self addEventHandler: h ].

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
					                      aSelectElement popupWindowManager
						                      popupWindowHiddenEvent: event ] ] ].
	self infinite addEventHandler: windowPopupHandler
]

{ #category : #'api - hooks' }
ToSelectFilterTextField >> onUninstalledIn: aSelectElement [

	installedEventHandler do: [ :h | self removeEventHandler: h ].
	installedEventHandler := #(  ).
	self infinite removeEventHandler: windowPopupHandler.
	windowPopupHandler := nil
]

{ #category : #accessing }
ToSelectFilterTextField >> selectFiltrable: aBoolean [

	aBoolean
		ifTrue: [
			self infinite focusability: self defaultFocusability.
			self beEditable ]
		ifFalse: [
			self infinite focusability: BlFocusability ignore.
			self beReadonlyWithoutSelection ]
]

{ #category : #accessing }
ToSelectFilterTextField >> selectNodeBefore [

	^ selectInnerContainer nodes
		  ifEmpty: [  ]
		  ifNotEmpty: [ :nodes | nodes last ]
]
