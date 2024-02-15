Class {
	#name : #ToThemeEditorAnimationInput,
	#superclass : #SpPresenter,
	#instVars : [
		'refreshLayoutButton',
		'nilInput',
		'classAnimationInput',
		'durationInput'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #accessing }
ToThemeEditorAnimationInput >> classAnimationInput [

	^ classAnimationInput
]

{ #category : #initialization }
ToThemeEditorAnimationInput >> connectPresenters [

	self nilInput whenChangedDo: [ :state |
		self classAnimationInput enabled: state.
		self durationInput enabled: state.
		self durationInput number = 0 ifTrue: [ self durationInput number: 500 ] ].
	self refreshLayoutButton action: [ self layout: self defaultLayout ].
	self classAnimationInput items:
		(ToPropertyAnimation allSubclasses reject: [ :each |
			 each isAbstract ]).
	
]

{ #category : #layout }
ToThemeEditorAnimationInput >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				add: self refreshLayoutButton expand: false;
				   add: self nilInput expand: true;
				yourself
				   )
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: 'animation' width: 70;
				   add: self classAnimationInput expand: true)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: 'ms' width: 70;
				   add: self durationInput expand: true)
		  expand: false;
		  yourself
]

{ #category : #accessing }
ToThemeEditorAnimationInput >> durationInput [

	^ durationInput
]

{ #category : #initialization }
ToThemeEditorAnimationInput >> initializePresenters [

	nilInput := SpCheckBoxPresenter new
		            label: 'has animation';
		            yourself.
	classAnimationInput := SpDropListPresenter new
		                       enabled: false;
		                       yourself.
	durationInput := SpNumberInputFieldPresenter new
		                 enabled: false;
		                 yourself.
	refreshLayoutButton := SpButtonPresenter new
		                       label: 'Reresh Layout';
		                       yourself
]

{ #category : #accessing }
ToThemeEditorAnimationInput >> nilInput [

	^ nilInput
]

{ #category : #layout }
ToThemeEditorAnimationInput >> refreshLayoutButton [

	^ refreshLayoutButton
]
