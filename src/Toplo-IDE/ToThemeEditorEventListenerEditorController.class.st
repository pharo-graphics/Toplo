Class {
	#name : #ToThemeEditorEventListenerEditorController,
	#superclass : #Object,
	#traits : 'TToThemeEditorController + TToThemeEditorObservable + TToThemeEditorEventListenersTreeObserver',
	#classTraits : 'TToThemeEditorController classTrait + TToThemeEditorObservable classTrait + TToThemeEditorEventListenersTreeObserver classTrait',
	#instVars : [
		'eventListener',
		'actionPresenter',
		'propertyPresenter'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> actionPresenter [

	^ actionPresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> currentSpecializeController [

	self eventListener ifNil: [ ^ SpNullPresenter new ].
	self isAction ifTrue: [ ^ self actionPresenter ].
	^ self propertyPresenter
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorController >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorController >> eventListener: anObject [

	eventListener := anObject.
	self actionPresenter eventListener: anObject.
	self propertyPresenter eventListener: anObject.
	self presenter updatePresenter.
	eventListener ifNil: [ ^ self ].
	
	self presenter eventClassDropList selectItem: eventListener eventClass.
	
	eventListener isAction ifTrue: [ self presenter actionRadio click ].
	eventListener isPropertyWriter ifTrue: [
		self presenter propertyRadio click ]
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorController >> initialize [

	propertyPresenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		                     new.
	actionPresenter := ToThemeEditorEventListenerSpecializedActionPresenter new
]

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> isAction [

	^ self presenter actionRadio state
]

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> isPresenterEnabled [

	^ self eventListener isNotNil
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> populateEventClassDropList: aSpDropListPresenter [

	aSpDropListPresenter items: (ToElementLookEvent allSubclasses reject: [ :each |
					                  each isAbstract ])
	
]

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> propertyPresenter [

	^ propertyPresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> replaceEventListener [

	| newEvent oldEvent |
	oldEvent := self eventListener.
	newEvent := self isAction
		            ifTrue: [ self actionPresenter makeNewEventListener ]
		            ifFalse: [ self propertyPresenter makeNewEventListener ].
	newEvent eventClass: self presenter eventClassDropList selectedItem.
	self observers do: [ :each |
		each replaceEventListener: oldEvent with: newEvent ]
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorController >> selectedEventListenerChanged: anEventListener [

	self eventListener: anEventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorController >> theme: aToTheme [

	self propertyPresenter theme: aToTheme
]
