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

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> makeNewAnimation [

	| animation |
	animation := self animationInput
		             evaluate: self animationInput text
		             onCompileError: [ :err | ^ err pass ]
		             onError: [ :err | ^ err pass ].
	animation ifNil: [ ^ nil ].
	(animation isKindOf: ToPropertyAnimation) ifFalse: [
		ToThemeEditorWrongObjectError new signal: 'Expected a BlAnimation.' ].
	^ animation
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> makeNewEventListener [

	| animation supplement value property |
	animation := self makeNewAnimation.
	supplement:= self makeNewSupplement.
	value:= self makeNewValue.
	property:= self makeNewProperty.
	
	^ ToPropertyWriter new
		  animation: animation;
		supplement: supplement;
		value: value;
		property: property;
		  yourself
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> makeNewProperty [

	^ self propertyInput selectedItem
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> makeNewSupplement [

	^ self supplementInput state
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> makeNewValue [

	| value |
	value := self valueInput
		         evaluate: self valueInput text
		         onCompileError: [ :err | ^ err pass ]
		         onError: [ :err | ^ err pass ].
	((value isKindOf: BlockClosure) and: [ value argumentCount ~= 1 ])
		ifTrue: [
			ToThemeEditorWrongObjectError new signal:
				'If value is a BlockClosure it should have one argument.' ].
	^ value
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

	| property |
	self eventListener animation
		ifNil: [
			self animationInput text: '"Put nil or a BlAnimation."
nil '.
			self animationInput beForObject: self eventListener animation ]
		ifNotNil: [
			self animationInput text:
				'"Put nil or a BlAnimation. Self is the current animation."
self '.
			self animationInput beForObject: self eventListener animation ].

	self supplementInput state: self eventListener isSupplement.
	self propertyInput selectItem: self eventListener property.
	self eventListener value isBlock
		ifTrue: [
		self valueInput text: self eventListener value printString ]
		ifFalse: [
			self valueInput text: '"self is the current value."
self '.
			self valueInput beForObject: self eventListener value ]
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> valueInput [

	^ valueInput
]
