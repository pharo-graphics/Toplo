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
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #'instance creation' }
ToploThemeEditor class >> openOn: aToStyleSheetTheme [

	^ (self with: aToStyleSheetTheme) open
]

{ #category : #'instance creation' }
ToploThemeEditor class >> with: aToStyleSheetTheme [

	^ self new theme: aToStyleSheetTheme; yourself
]

{ #category : #initialization }
ToploThemeEditor >> changeListener: newListener with: oldListener in: styleRule [

	styleRule removeLookEventListener: oldListener.
	styleRule addLookEventListener: newListener.
	self panelEventsSelector updatePresenterOn: newListener.
	self panelEventEditor eventListener: newListener.
]

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
		newStyleRule class = ToStyleRule
			ifTrue: [
				self panelRuleEditor styleRule: newStyleRule.
				self panelEventsSelector styleRule: newStyleRule ]
			ifFalse: [
				self panelRuleEditor styleRule: nil.
				self panelEventsSelector styleRule: nil ] ]
]

{ #category : #initialization }
ToploThemeEditor >> connectPresenters [

	self connectPanelRulesSelector.
	self connectPanelEventsSelector.

	self panelEventEditor whenListenerChangedDo: [
		:newListener
		:oldListener |
		self
			changeListener: newListener
			with: oldListener
			in: self panelRuleEditor styleRule ]
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
	panelEventEditor := ToploPanelEventEditorPresenter new theme: self; yourself.
	panelRulesSelector := ToploPanelRulesSelectorPresenter new.
	panelRuleEditor := ToploPanelRuleEditorPresenter new.
	panelTheme := ToploPanelThemePresenter new
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
