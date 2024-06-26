Class {
	#name : #ToThemeEditorEventListenerSpecializedActionPresenterTest,
	#superclass : #TestCase,
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testEventListener1 [

	| presenter |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter eventListener: nil.
	self
		assert: presenter actionInput text
		equals: presenter textForActionInputWhenNil
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testEventListener2 [

	| presenter |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter eventListener: ToPropertyWriter new.
	self
		assert: presenter actionInput text
		equals: presenter textForActionInputWhenProperty
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testEventListener3 [

	| presenter |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter eventListener: (ToSkinEventAction new
			 action: [ :test1 |  ];
			 yourself).
	self assert: presenter actionInput text equals: '[ :test1 |  ]'.
	presenter eventListener: (ToSkinEventAction new
			 action: [ :test2 |  ];
			 yourself).
	self assert: presenter actionInput text equals: '[ :test2 |  ]'.
	presenter eventListener: (ToSkinEventAction new
			 action: [ :test3 | nil toto titi tutu ];
			 yourself).
	self
		assert: presenter actionInput text
		equals: '[ :test3 | nil toto titi tutu ]'
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testMakeNewEventListener1 [

	| presenter eventListener |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.
	presenter actionInput text: '[ :helloWorld | ]'.
	eventListener := presenter makeNewEventListener.
	self assert: eventListener class equals: ToSkinEventAction.
	self assert: (eventListener action isKindOf: BlockClosure).
	self assert: eventListener action argumentCount equals: 1.
	self
		assert: eventListener action printString
		equals: '[ :helloWorld | ]'
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testMakeNewEventListener2 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.

	error := false.
	presenter actionInput text: 'Object new'.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testMakeNewEventListener3 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.

	error := false.
	presenter actionInput text: 'nil'.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testMakeNewEventListener4 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.

	error := false.
	presenter actionInput text: '[ ]'.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error
]

{ #category : #tests }
ToThemeEditorEventListenerSpecializedActionPresenterTest >> testMakeNewEventListener5 [

	| presenter error |
	presenter := ToThemeEditorEventListenerSpecializedActionPresenter new.

	error := false.
	presenter actionInput text: '[ :toto :titi | ]'.
	[ presenter makeNewEventListener ]
		on: ToThemeEditorWrongObjectError
		do: [ :err | error := true ].
	self assert: error
]
