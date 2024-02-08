Class {
	#name : #ToThemeEditorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'rulesTree',
		'eventListenersList',
		'selectorEditor',
		'eventListenerEditor',
		'themeInfos'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-main'
}

{ #category : #initialization }
ToThemeEditorPresenter >> connectPresenters [

	rulesTree controller addObserver: eventListenersList controller.
	rulesTree controller addObserver: selectorEditor controller.

	selectorEditor controller addObserver: rulesTree controller.

	eventListenersList controller addObserver: eventListenerEditor controller.
	eventListenerEditor controller addObserver: eventListenersList controller
]

{ #category : #layout }
ToThemeEditorPresenter >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 4 / 5;
		  add: (SpPanedLayout newHorizontal
				   add: (SpPanedLayout newHorizontal
						    add: self rulesTree;
						    add: self eventListenersList;
						    yourself);
				   add: (SpBoxLayout newVertical
						    spacing: 4;
						    add: self selectorEditor expand: false;
						    add: self eventListenerEditor;
						    yourself);
				   yourself);
		  add: self themeInfos;
		  yourself
]

{ #category : #layout }
ToThemeEditorPresenter >> eventListenerEditor [

	^ eventListenerEditor
]

{ #category : #layout }
ToThemeEditorPresenter >> eventListenersList [

	^ eventListenersList
]

{ #category : #initialization }
ToThemeEditorPresenter >> initializePresenters [

	rulesTree := ToThemeEditorRulesTreePresenter new.
	eventListenersList := ToThemeEditorEventsListenerListPresenter new.
	selectorEditor := ToThemeEditorRuleSelectorEditor new.
	eventListenerEditor := ToThemeEditorEventListenerEditorPresenter new.
	themeInfos := ToThemeEditorThemeInfos new.

]

{ #category : #layout }
ToThemeEditorPresenter >> rulesTree [

	^ rulesTree
]

{ #category : #layout }
ToThemeEditorPresenter >> selectorEditor [

	^ selectorEditor
]

{ #category : #accessing }
ToThemeEditorPresenter >> theme: aToTheme [

	self rulesTree controller theme: aToTheme.
	self eventListenerEditor controller theme: aToTheme.
	self themeInfos controller theme: aToTheme.
]

{ #category : #accessing }
ToThemeEditorPresenter >> themeInfos [

	^ themeInfos
]
