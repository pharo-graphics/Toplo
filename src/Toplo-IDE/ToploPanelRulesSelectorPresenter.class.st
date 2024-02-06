Class {
	#name : #ToploPanelRulesSelectorPresenter,
	#superclass : #ToploPanelWithButtonPresenter,
	#instVars : [
		'theme',
		'shouldTriggerSelctionUpdate'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> addToStyleRule: aToStyleRule [

	| newRule |
	newRule := self defaultStyleRule.
	aToStyleRule addStyleRule: newRule.
	self updateContentOn: newRule
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> addToTheme [

	| newRule |
	newRule := self defaultStyleRule.
	self theme lookEventListenerHolder addStyleRule: newRule.
	self updateContentOn: newRule
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> defaultStyleRule [

	^ ToStyleRule new selector: ToUniversalSelector new; yourself
]

{ #category : #'as yet unclassified' }
ToploPanelRulesSelectorPresenter >> doNotTriggerWhile: aFullBlockClosure [ 
	self shouldTriggerSelctionUpdate: false.
	aFullBlockClosure value.
	self shouldTriggerSelctionUpdate: true.
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> initializePresenters [

	super initializePresenters.
	shouldTriggerSelctionUpdate := true.
	panelContent := SpTreeTablePresenter new
		                children: [ :rule | rule styleRules ];
		                whenSelectedItemChangedDo: [ :rule |
			                self selectRule: rule ];
		                contextMenu: (SpMenuPresenter new
				                 addItem: [ :item |
					                 item
						                 icon: (self iconNamed: #smallInspectIt);
						                 name: 'Inspect';
						                 action: [
							                 self panelContent selectedItem inspect ];
						                 yourself ];
				                 yourself);
		                expandRoots;
		                yourself
]

{ #category : #'as yet unclassified' }
ToploPanelRulesSelectorPresenter >> panelName [

	^ 'Rules selection'
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> refreshTree [
	self doNotTriggerWhile: [
		self panelContent
			roots: { self theme };
			expandRoots ].
	
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> removeToStyleRule: aToStyleRule [

	(SpDialogWindowPresenter presenter: (SpLabelPresenter new
				  label: 'Are you sure to delete the selected rule ?';
				  yourself))
		okAction: [
			| parentRule |
			parentRule := self panelContent itemAtPath:
				              self panelContent selection selectedPath allButLast.
			parentRule == self theme
				ifTrue: [
					self theme lookEventListenerHolder removeStyleRule: aToStyleRule.
					self updateContentOnTheme ]
				ifFalse: [
					parentRule removeStyleRule: aToStyleRule.
					self updateContentAfterRemoveOn: parentRule ] ];
		open
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> selectRule: aToStyleRule [

	self shouldTriggerSelctionUpdate ifFalse: [ ^ self ].
	aToStyleRule ifNil: [
		self buttonRemove enabled: false.
		self buttonAdd enabled: false.
		^ self ].
	self buttonAdd enabled: true.
	aToStyleRule == self theme ifTrue: [
		self buttonRemove enabled: false.
		self buttonAdd action: [ self addToTheme ].
		^ self ].
	self buttonRemove enabled: true.
	self buttonAdd action: [ self addToStyleRule: aToStyleRule ].
	self buttonRemove action: [
		self removeToStyleRule: aToStyleRule.
	 ]
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> shouldTriggerSelctionUpdate [

	^ shouldTriggerSelctionUpdate
]

{ #category : #asserting }
ToploPanelRulesSelectorPresenter >> shouldTriggerSelctionUpdate: aBoolean [ 
	shouldTriggerSelctionUpdate:= aBoolean
]

{ #category : #accessing }
ToploPanelRulesSelectorPresenter >> theme [
	^ theme
]

{ #category : #accessing }
ToploPanelRulesSelectorPresenter >> theme: aToTheme [

	theme := aToTheme.
	self updateContentOnTheme
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> updateContentAfterRemoveOn: aToStyleRule [

	| curentSelection newPath |
	curentSelection := self panelContent selection.
	newPath := curentSelection selectedPath
	           allButLast.
	self refreshTree.
	self panelContent selectPath: newPath scrollToSelection: true
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> updateContentOn: aToStyleRule [

	| curentSelection newPath |
	curentSelection := self panelContent selection.
	newPath := curentSelection selectedPath
	           ,
		           { ((self panelContent childrenFor:
			             self panelContent selectedItem) indexOf: aToStyleRule) }.
	self refreshTree.
	self doNotTriggerWhile: [
		self panelContent
			roots: { self theme };
			expandRoots ].
	self panelContent selectPath: newPath scrollToSelection: true
]

{ #category : #initialization }
ToploPanelRulesSelectorPresenter >> updateContentOnTheme [

	self refreshTree.
	self panelContent selectItem: self theme
]
