Class {
	#name : #ToploPanelRulesSelectorPresenter,
	#superclass : #ToploPanelWithButtonPresenter,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> initializePresenters [

	super initializePresenters.
	panelContent := SpTreeTablePresenter new children: [ :rule | rule styleRules ]; yourself
]

{ #category : #'as yet unclassified' }
ToploPanelRulesSelectorPresenter >> panelName [

	^ 'Rules selection'
]

{ #category : #accessing }
ToploPanelRulesSelectorPresenter >> theme: aToTheme [

	self panelContent items:
		aToTheme styleSheet styleRules
]
