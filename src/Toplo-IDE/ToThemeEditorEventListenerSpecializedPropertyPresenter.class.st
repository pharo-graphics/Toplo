Class {
	#name : #ToThemeEditorEventListenerSpecializedPropertyPresenter,
	#superclass : #ToThemeEditorEventListenerSpecializedPresenter,
	#instVars : [
		'eventListener',
		'animationInput',
		'propertyInput',
		'valueInput',
		'supplementInput'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> animationInput [

	^ animationInput
]

{ #category : #layout }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: 'Property' expand: false;
		  add: self propertyInput expand: false;
		  add: self supplementInput expand: false;
		  add: 'Value' expand: false;
		  add: self valueInput;
		  add: 'Animation' expand: false;
		  add: self animationInput;
		  yourself
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> eventListener: anObject [

	eventListener := anObject.
	eventListener ifNil: [ ^ self ].
	eventListener isPropertyWriter ifFalse: [ ^ self ].
	self updatePresenter
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> initializePresenters [

	propertyInput := SpDropListPresenter new display: [:prop | prop name ]; yourself.
	supplementInput := SpCheckBoxPresenter new
		                   label: 'supplement';
		                   yourself.
	animationInput := SpCodePresenter new
		                  beForScripting;
		                  yourself.
	valueInput := SpCodePresenter new
		              beForScripting;
		              yourself
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> propertyInput [

	^ propertyInput
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> supplementInput [

	^ supplementInput
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> theme: aToTheme [

	self propertyInput items:
		((aToTheme styleSheet writablePropertyIndex allProperties collect: [
			 :each | each value ]) sorted: [ :a :b | a name < b name ])
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> updatePresenter [

	self eventListener ifNil: [
		self updatePresenterForNil.
		^ self ].
	self eventListener isPropertyWriter ifFalse: [
		self updatePresenterForActionEvent.
		^ self ].
	self updatePresenterForPropertyEvent.
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> updatePresenterForActionEvent [

	self animationInput text: '"Write here an animation."'.
	self supplementInput state: false.
	self propertyInput resetSelection.
	self valueInput text: '"Write here a value."'
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> updatePresenterForNil [

	self animationInput text: '"Write here an animation."'.
	self supplementInput state: false.
	self propertyInput resetSelection.
	self valueInput text: '"Write here a value."'
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> updatePresenterForPropertyEvent [

	self animationInput text: '"self is the current animation."
self '.
	self supplementInput state: self eventListener isSupplement.
	self propertyInput selectItem: self eventListener property.
	self eventListener value isBlock ifTrue: [ self valueInput text: self eventListener value printString ] ifFalse: [ self valueInput text: '"self is the current value."
self '. ].
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> valueInput [

	^ valueInput
]
