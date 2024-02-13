Class {
	#name : #ToThemeEditorEventListenerSpecializedPropertyPresenterTest,
	#superclass : #TestCase,
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener1 [

	| presenter |
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter eventListener: nil.
	self
		assert: presenter animationInput text
		equals: presenter textForAnimationInputWhenNil.
	self
		assert: presenter valueInput text
		equals: presenter textForValueInputWhenNil.
	self
		assert: presenter propertyInput selectedItem
		equals: nil.
	self
		assert: presenter supplementInput state
		equals: false
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener2 [

	| presenter |
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter eventListener: ToLookEventAction new.
	self
		assert: presenter animationInput text
		equals: presenter textForAnimationInputWhenAction.
	self
		assert: presenter valueInput text
		equals: presenter textForValueInputWhenAction.
	self assert: presenter propertyInput selectedItem equals: nil.
	self assert: presenter supplementInput state equals: false
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener3 [

	| presenter property1 property2 |
	property1 := ToFeatureProperty name: #background.
	property2 := ToFeatureProperty name: #size.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
		presenter propertyInput items: { property1 . property2 }.
	presenter eventListener: (ToPropertyWriter new
			 supplement: false;
			animation: nil;
			value: Color red;
			property: property1;
			 yourself).
	self
		assert: presenter makeNewAnimation
		equals: nil.
	self
		assert: presenter makeNewValue
		equals: Color red.
	self assert: presenter propertyInput selectedItem equals: property1.
	self assert: presenter supplementInput state equals: false
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener4 [

	| presenter property1 property2 |
	property1 := ToFeatureProperty name: #background.
	property2 := ToFeatureProperty name: #size.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter propertyInput items: {
			property1.
			property2 }.
	presenter eventListener: (ToPropertyWriter new
			 supplement: false;
			 animation: nil;
			 value: Color red;
			 property: property2;
			 yourself).
	self assert: presenter makeNewAnimation equals: nil.
	self assert: presenter makeNewValue equals: Color red.
	self assert: presenter propertyInput selectedItem equals: property2.
	self assert: presenter supplementInput state equals: false
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener5 [

	| presenter property1 property2 |
	property1 := ToFeatureProperty name: #background.
	property2 := ToFeatureProperty name: #size.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter propertyInput items: {
			property1.
			property2 }.
	presenter eventListener: (ToPropertyWriter new
			 supplement: true;
			 animation: nil;
			 value: Color red;
			 property: property1;
			 yourself).
	self assert: presenter makeNewAnimation equals: nil.
	self assert: presenter makeNewValue equals: Color red.
	self assert: presenter propertyInput selectedItem equals: property1.
	self assert: presenter supplementInput state equals: true
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener6 [

	| presenter property1 property2 |
	property1 := ToFeatureProperty name: #background.
	property2 := ToFeatureProperty name: #size.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter propertyInput items: {
			property1.
			property2 }.
	presenter eventListener: (ToPropertyWriter new
			 supplement: false;
			 animation: nil;
			 value: [ :e | Color red ];
			 property: property1;
			 yourself).
	self assert: presenter makeNewAnimation equals: nil.
	self assert: presenter valueInput text equals: '[:e |  Color red ]'.
	self assert: presenter propertyInput selectedItem equals: property1.
	self assert: presenter supplementInput state equals: false
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testEventListener7 [

	| presenter property1 property2 |
	property1 := ToFeatureProperty name: #background.
	property2 := ToFeatureProperty name: #size.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter propertyInput items: {
			property1.
			property2 }.
	presenter eventListener: (ToPropertyWriter new
			 supplement: false;
			 animation:
				 (ToPropertyColorTransitionAnimation new duration:
						  150 milliSeconds);
			 value: Color red;
			 property: property1;
			 yourself).
	self assert: presenter makeNewAnimation class equals: ToPropertyColorTransitionAnimation.
	self assert: presenter makeNewAnimation duration equals: 150 milliSeconds.
	self assert: presenter makeNewValue equals: Color red.
	self assert: presenter propertyInput selectedItem equals: property1.
	self assert: presenter supplementInput state equals: false
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener1 [

	| presenter eventListener |
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'nil'.
	presenter propertyInput items: {ToFeatureProperty name: #background}.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: false.
	presenter valueInput text: 'Color red'.
	eventListener := presenter makeNewEventListener.
	self assert: eventListener class equals: ToPropertyWriter.
	self assert: eventListener isSupplement equals: false.
	self assert: eventListener animation equals: nil.
	self assert: eventListener value equals: Color red.
	self assert: eventListener property class equals: ToFeatureProperty.
	self assert: eventListener property name equals: #background.
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener2 [

	| presenter eventListener |
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'nil'.
	presenter propertyInput items:
		{ (ToFeatureProperty name: #background) }.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: true.
	presenter valueInput text: 'Color red'.
	eventListener := presenter makeNewEventListener.
	self assert: eventListener class equals: ToPropertyWriter.
	self assert: eventListener isSupplement equals: true.
	self assert: eventListener animation equals: nil.
	self assert: eventListener value equals: Color red.
	self assert: eventListener property class equals: ToFeatureProperty.
	self assert: eventListener property name equals: #background
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener3 [

	| presenter eventListener |
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'nil'.
	presenter propertyInput items:
		{ (ToFeatureProperty name: #background) }.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: false.
	presenter valueInput text: '[ :e | Color red ]'.
	eventListener := presenter makeNewEventListener.
	self assert: eventListener class equals: ToPropertyWriter.
	self assert: eventListener isSupplement equals: false.
	self assert: eventListener animation equals: nil.
	self assert: (eventListener value isKindOf: BlockClosure).
	self assert: eventListener value argumentCount equals: 1.
	self
		assert: eventListener value printString
		equals: '[ :e | Color red ]'.
	self assert: eventListener property class equals: ToFeatureProperty.
	self assert: eventListener property name equals: #background
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener4 [

	| presenter eventListener |
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'ToPropertyColorTransitionAnimation new duration: 150 milliSeconds.'.
	presenter propertyInput items:
		{ (ToFeatureProperty name: #background) }.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: false.
	presenter valueInput text: 'Color red'.
	eventListener := presenter makeNewEventListener.
	self assert: eventListener class equals: ToPropertyWriter.
	self assert: eventListener isSupplement equals: false.
	self assert: eventListener animation class equals: ToPropertyColorTransitionAnimation.
	self assert: eventListener animation duration equals: 150 milliSeconds.
	self assert: eventListener value equals: Color red.
	self assert: eventListener property class equals: ToFeatureProperty.
	self assert: eventListener property name equals: #background
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener5 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'Object new'.
	presenter propertyInput items:
		{ (ToFeatureProperty name: #background) }.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: false.
	presenter valueInput text: 'Color red'.


	error := false.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error.

]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener6 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'nil'.
	presenter propertyInput items:
		{ (ToFeatureProperty name: #background) }.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: false.
	presenter valueInput text: '[ ]'.


	error := false.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedPropertyPresenterTest >> testMakeNewEventListener7 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter := ToThemeEditorEventListenerSpecializedPropertyPresenter
		             new.
	presenter animationInput text: 'nil'.
	presenter propertyInput items:
		{ (ToFeatureProperty name: #background) }.
	presenter propertyInput selectIndex: 1.
	presenter supplementInput state: false.
	presenter valueInput text: '[:toto :titi | ]'.


	error := false.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error
]
