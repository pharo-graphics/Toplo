Class {
	#name : #ToThemeEditorEventsListenerListController,
	#superclass : #Object,
	#traits : 'TToThemeEditorControllerWithButtons + TToThemeEditorRulesTreeObserver + TToThemeEditorObservable + TToThemeEditorEventListenerEditorObserver',
	#classTraits : 'TToThemeEditorControllerWithButtons classTrait + TToThemeEditorRulesTreeObserver classTrait + TToThemeEditorObservable classTrait + TToThemeEditorEventListenerEditorObserver classTrait',
	#instVars : [
		'styleRule',
		'isTriggerSelectedRuleChanged'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListeners'
}

{ #category : #adding }
ToThemeEditorEventsListenerListController >> addEventListener [

	| newEventListener |
	self styleRule ifNil: [ ^ self ].
	newEventListener := ToLookEventAction new action: [ :element |  ]; eventClass: ToInstallLookEvent; yourself.
	self styleRule addLookEventListener: newEventListener.
	self updatePresenterOn: newEventListener
	
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> allEventListeners [

	self styleRule ifNil: [ ^ {  } ].
	^ self styleRule lookEventListeners
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> doNotTriggerSelectedRuleChanged [

	isTriggerSelectedRuleChanged := false
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> doNotTriggerSelectedRuleChangedWhile: aBlock [

	self doNotTriggerSelectedRuleChanged.
	aBlock value.
	self doTriggerSelectedRuleChanged
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> doTriggerSelectedRuleChanged [

	isTriggerSelectedRuleChanged := true
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> initialize [ 

	isTriggerSelectedRuleChanged := true
]

{ #category : #testing }
ToThemeEditorEventsListenerListController >> isButtonAddEnabled [

	^ self styleRule isNotNil
]

{ #category : #testing }
ToThemeEditorEventsListenerListController >> isButtonRemoveEnabled [

	self styleRule ifNil: [ ^ false ].
	^ self presenter eventListenersList selectedItem isNotNil
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> isTriggerSelectedRuleChanged [

	^ isTriggerSelectedRuleChanged
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> removeEventListener: anEventListener [

	self styleRule ifNil: [ ^ self ].
	self styleRule removeLookEventListener: anEventListener.
	self styleRule: self styleRule
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> selectedEventListenerChanged: anEventListener [

	self isTriggerSelectedRuleChanged ifFalse: [ ^ self ].
	self observers do: [ :each |
		each selectedEventListenerChanged: anEventListener ]
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> selectedRuleChanged: aToStyleRule [

	self styleRule: aToStyleRule
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> styleRule [

	^ styleRule
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> styleRule: aToStyleRule [

	styleRule := aToStyleRule.
	self presenter eventListenersList items: self allEventListeners.
	self presenter updatePresenter.
	self allEventListeners ifEmpty: [ ^ self ].
	self presenter eventListenersList selectItem:
		self allEventListeners first.
		self presenter updatePresenterOnlyButtons
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> updatePresenterOn: aToLookEventAction [

	self doNotTriggerSelectedRuleChangedWhile: [
		self presenter updatePresenter ].
	self presenter eventListenersList selectItem: aToLookEventAction
]
