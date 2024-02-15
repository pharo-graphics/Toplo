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
	self updatePresenter
	
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> initializePresenters [

	propertyInput := SpDropListPresenter new
		                 display: [ :prop | prop name ];
		                 yourself.
	supplementInput := SpCheckBoxPresenter new
		                   label: 'supplement';
		                   yourself.
	animationInput := SpCodePresenter new
		                  beForScripting;
		                  yourself.
	valueInput := SpCodePresenter new
		              beForScripting;
		              yourself.
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
		ToThemeEditorWrongObjectError new signal: 'Expected a ToPropertyAnimation.' ].
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

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> textForAnimationInputWhenAction [

	^ self textForAnimationInputWhenNil
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> textForAnimationInputWhenNil [

	^ '"Write here an animation."'.
	
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> textForValueInputWhenAction [

	^ self textForValueInputWhenNil
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> textForValueInputWhenNil [

	^ '"Write here a value."'
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
		self updatePresenterForNilOrAction.
		^ self ].
	self eventListener isPropertyWriter ifFalse: [
		self updatePresenterForNilOrAction.
		^ self ].
	self updatePresenterForPropertyEvent
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> updatePresenterForNilOrAction [

	self animationInput text: self textForAnimationInputWhenNil.
	self supplementInput state: false.
	self propertyInput resetSelection.
	self valueInput text: self textForValueInputWhenNil
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> updatePresenterForPropertyEvent [

	self eventListener animation
		ifNil: [
			self animationInput text: '"Put nil or a ToPropertyAnimation."
nil ' ]
		ifNotNil: [
			| visitor |
			visitor := ToThemeToSourceCodeVisitor new.
			self eventListener animation accept: visitor.
			self animationInput text: '"Put nil or a ToPropertyAnimation."
' , visitor contents ].

	self supplementInput state: self eventListener isSupplement.
	self propertyInput selectItem: self eventListener property.
	self eventListener value isBlock
		ifTrue: [
			| expr |
			expr := RBParser parseExpression: self eventListener value printString.
			self valueInput text: (RBSimpleFormatter format: expr) ]
		ifFalse: [
			self valueInput text: '"self is the current value."
self '.
			self valueInput beForObject: self eventListener value ]
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedPropertyPresenter >> valueInput [

	^ valueInput
]
