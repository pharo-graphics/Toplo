Class {
	#name : #ToploThemeEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'panelTheme',
		'panelRulesSelector',
		'panelRuleEditor',
		'panelEventsSelector',
		'panelEventEditor'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #'as yet unclassified' }
ToploThemeEditor >> connectPanelEventsSelector [

	self panelEventsSelector panelContent whenSelectedItemChangedDo: [
		:newEventListener |
		self panelEventEditor eventListener: newEventListener.
		 ]
]

{ #category : #'as yet unclassified' }
ToploThemeEditor >> connectPanelRulesSelector [

	self panelRulesSelector panelContent whenSelectedItemChangedDo: [
		:newStyleRule |
		self panelRuleEditor styleRule: newStyleRule.
		newStyleRule
			ifNil: [ self panelEventsSelector panelContent items: {  } ]
			ifNotNil: [
				self panelEventsSelector panelContent items:
					newStyleRule lookEventListeners.
					newStyleRule lookEventListeners ifNotEmpty: [ self panelEventsSelector panelContent selectIndex: 1 ]
					 ] ]
]

{ #category : #initialization }
ToploThemeEditor >> connectPresenters [

	self connectPanelRulesSelector.
	self connectPanelEventsSelector
]

{ #category : #layout }
ToploThemeEditor >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 1 / 6;
		  first: self panelRulesSelector;
		  second: (SpPanedLayout newHorizontal
				   positionOfSlider: 1 / 5;
				   first: self panelEventsSelector;
				   second: (SpPanedLayout newHorizontal
						    positionOfSlider: 3 / 4;
						    first: (SpBoxLayout newVertical
								     spacing: 4;
								     add: self panelRuleEditor expand: false;
								     add: self panelEventEditor expand: true;
								     yourself);
						    second: self panelTheme;
						    yourself))
]

{ #category : #initialization }
ToploThemeEditor >> initializePresenters [

	panelEventsSelector := ToploPanelEventsSelectorPresenter new.
	panelEventEditor := ToploPanelEventEditorPresenter new.
	panelRulesSelector := ToploPanelRulesSelectorPresenter new.
	panelRuleEditor := ToploPanelRuleEditorPresenter new.
	panelTheme := ToploPanelThemePresenter new.
	
]

{ #category : #accessing }
ToploThemeEditor >> panelEventEditor [

	^ panelEventEditor
]

{ #category : #accessing }
ToploThemeEditor >> panelEventsSelector [

	^ panelEventsSelector
]

{ #category : #accessing }
ToploThemeEditor >> panelRuleEditor [

	^ panelRuleEditor
]

{ #category : #accessing }
ToploThemeEditor >> panelRulesSelector [

	^ panelRulesSelector
]

{ #category : #accessing }
ToploThemeEditor >> panelTheme [

	^ panelTheme
]

{ #category : #accessing }
ToploThemeEditor >> theme: aToTheme [ 

	self panelTheme theme: aToTheme.
	self panelEventEditor theme: aToTheme.
	self panelEventsSelector theme: aToTheme.
	self panelRuleEditor theme: aToTheme.
	self panelRulesSelector theme: aToTheme.
]
