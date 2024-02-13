Class {
	#name : #ToThemeEditorEventListenerEditorController,
	#superclass : #Object,
	#traits : 'TToThemeEditorController + TToThemeEditorObservable + TToThemeEditorEventListenersTreeObserver',
	#classTraits : 'TToThemeEditorController classTrait + TToThemeEditorObservable classTrait + TToThemeEditorEventListenersTreeObserver classTrait',
	#instVars : [
		'eventListener',
		'actionPresenter',
		'propertyPresenter',
		'allEventClasses',
		'nullPresenter'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> actionPresenter [

	^ actionPresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> allEventClasses [

	^ allEventClasses ifNil: [allEventClasses := ToElementLookEvent allSubclasses reject: [ :each | each isAbstract ]]
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> currentSpecializeController [

	self eventListener ifNil: [ ^ self nullPresenter  ].
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
	self presenter updatePresenter.


	self actionPresenter eventListener: anObject.
	self propertyPresenter eventListener: anObject.

	eventListener ifNil: [ ^ self ].
	eventListener isAction ifTrue: [ self presenter actionRadio click ].
	eventListener isPropertyWriter ifTrue: [
		self presenter propertyRadio click ].

	self presenter eventClassDropList selectIndex:
		(self indexOfEventClass: eventListener eventClass).
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> indexOfEventClass: anEventClass [

^ allEventClasses indexOf: anEventClass.

]

{ #category : #initialization }
ToThemeEditorEventListenerEditorController >> initialize [

	propertyPresenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		                     new.
	actionPresenter := ToThemeEditorEventListenerSpecializedActionPresenter
		                   new.
		nullPresenter := SpNullPresenter new
]

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> isAction [

	^ self presenter actionRadio state
]

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> isPresenterEnabled [

	^ self eventListener isNotNil
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorController >> nullPresenter [

	^ nullPresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> populateEventClassDropList: aSpDropListPresenter [

	aSpDropListPresenter items: self allEventClasses.
		(ToElementLookEvent allSubclasses reject: [ :each | each isAbstract ])
]

{ #category : #testing }
ToThemeEditorEventListenerEditorController >> propertyPresenter [

	^ propertyPresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerEditorController >> replaceEventListener [

	| newEvent oldEvent |
	oldEvent := self eventListener.
	[
	newEvent := self isAction
		            ifTrue: [ self actionPresenter makeNewEventListener ]
		            ifFalse: [ self propertyPresenter makeNewEventListener ].
	newEvent eventClass: self presenter eventClassDropList selectedItem.
	self observers do: [ :each |
		each replaceEventListener: oldEvent with: newEvent ] ] on: Error do: [ :err | err pass ]
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorController >> selectedEventListenerChanged: anEventListener [

	self eventListener: anEventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorController >> theme: aToTheme [

	self propertyPresenter theme: aToTheme
]
