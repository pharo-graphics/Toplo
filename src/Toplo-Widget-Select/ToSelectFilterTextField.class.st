Class {
	#name : #ToSelectFilterTextField,
	#superclass : #ToTextField,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-Filter-TextField'
}

{ #category : #initialization }
ToSelectFilterTextField >> defaultEventHandler [ 

	^ ToSelectFilterTextFieldEventHandler new
]

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
ToSelectFilterTextField >> on: aSelectElement [

	| windowPopupHandler |
	selectElement := aSelectElement.
	self withoutLineWrapping.
	self id: #filterTextField.
	self selectFiltrable: aSelectElement isFiltrable.

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
					                      aSelectElement manager
						                      popupWindowHiddenEvent: event ] ] ].
	self infinite addEventHandler: windowPopupHandler
]

{ #category : #accessing }
ToSelectFilterTextField >> selectElement [

	^ selectElement
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

	^ selectElement innerElement nodes
		  ifEmpty: [  ]
		  ifNotEmpty: [ :nodes | nodes last ]
]
