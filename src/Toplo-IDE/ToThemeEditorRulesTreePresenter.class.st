Class {
	#name : #ToThemeEditorRulesTreePresenter,
	#superclass : #SpPresenter,
	#traits : 'TToThemeEditorPresenterWithButtons',
	#classTraits : 'TToThemeEditorPresenterWithButtons classTrait',
	#instVars : [
		'rulesTree'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-rulesTree'
}

{ #category : #accessing }
ToThemeEditorRulesTreePresenter >> actionAddButton [

	self controller addNewRuleTo: self rulesTree selectedItem
]

{ #category : #accessing }
ToThemeEditorRulesTreePresenter >> actionRemoveButton [

	self controller removeRule: self rulesTree selectedItem
]

{ #category : #accessing }
ToThemeEditorRulesTreePresenter >> addHelp [

	^ 'Add a new rule with a universal selector and no events listeners.'.
]

{ #category : #accessing }
ToThemeEditorRulesTreePresenter >> controllerClass [

	^ ToThemeEditorRulesTreeController
]

{ #category : #layout }
ToThemeEditorRulesTreePresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpLabelPresenter new
				   label: 'Style Rules';
				   displayBold: [ :t | true ];
				   yourself)
		  expand: false;
		  add: self rulesTree expand: true;
		  add: self buttonsLayout expand: false;
		  yourself
]

{ #category : #initialization }
ToThemeEditorRulesTreePresenter >> initializePresenters [

	rulesTree := SpTreeTablePresenter new
		             children: [ :aToStyleRule | aToStyleRule styleRules ];
		             whenSelectedItemChangedDo: [ :aToStyleRule |
			             self selectedRuleChanged: aToStyleRule ];
		             contextMenu: self ruleTreeMenu;
		             expandRoots;
		             yourself.
	rulesTree addColumn:
		(SpStringTableColumn title: 'Selector' evaluated: [ :styleRule |
			 styleRule == rulesTree roots first
				 ifTrue: [ styleRule printString ]
				 ifFalse: [
					 | printer |
					 printer := ToSelectorPrinter new.
					 styleRule selector accept: printer.
					 printer contents ] ])
]

{ #category : #accessing }
ToThemeEditorRulesTreePresenter >> removeHelp [

	^ 'Remove the selected rule and all their subrules.'.
]

{ #category : #initialization }
ToThemeEditorRulesTreePresenter >> ruleTreeMenu [

	^ SpMenuPresenter new
		  addItem: [ :item |
			  item
				  icon: (self iconNamed: #smallInspectIt);
				  name: 'Inspect';
				  action: [ self rulesTree selectedItem inspect ];
				  yourself ];
		  yourself
]

{ #category : #accessing }
ToThemeEditorRulesTreePresenter >> rulesTree [

	^ rulesTree
]

{ #category : #initialization }
ToThemeEditorRulesTreePresenter >> selectedRuleChanged: aToStyleRule [

	self controller selectedRuleChanged: aToStyleRule
]

{ #category : #initialization }
ToThemeEditorRulesTreePresenter >> updatePresenter [

	self rulesTree roots: self rulesTree roots.
	self rulesTree expandRoots.
	self updatePresenterOnlyButtons
]
