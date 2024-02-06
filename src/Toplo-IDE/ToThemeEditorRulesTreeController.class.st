Class {
	#name : #ToThemeEditorRulesTreeController,
	#superclass : #Object,
	#traits : 'TToThemeEditorControllerWithButtons + TToThemeEditorControllerObservable',
	#classTraits : 'TToThemeEditorControllerWithButtons classTrait + TToThemeEditorControllerObservable classTrait',
	#instVars : [
		'isTriggerSelectedRuleChanged'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-rulesTree'
}

{ #category : #adding }
ToThemeEditorRulesTreeController >> addNewRuleTo: aToStyleRule [

	| newStyleRule |
	newStyleRule := ToStyleRule new
		                selector: ToUniversalSelector new;
		                yourself.
	aToStyleRule addStyleRule: newStyleRule.
	self updateSelectionAfterAdding: newStyleRule
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> doNotTriggerSelectedRuleChanged [

	isTriggerSelectedRuleChanged := false
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> doNotTriggerSelectedRuleChangedWhile: aBlock [

	self doNotTriggerSelectedRuleChanged.
	aBlock value.
	self doTriggerSelectedRuleChanged.
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> doTriggerSelectedRuleChanged [

	isTriggerSelectedRuleChanged := true
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> initialize [

	isTriggerSelectedRuleChanged := true.
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> isButtonAddEnabled [

	^ self presenter rulesTree selectedItem isNotNil
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> isButtonRemoveEnabled [

	self presenter rulesTree selectedItem ifNil: [ ^ false ].
	^ self presenter rulesTree roots first
	  ~= self presenter rulesTree selectedItem
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> isTriggerSelectedRuleChanged [

	^ isTriggerSelectedRuleChanged
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> removeDialogText [

	^ 'Are you sure to delete the selected rule ?'
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> removeRule:  aToStyleRule [

	| okAction |
	okAction := [
	            | parentRule |
	            parentRule := self presenter rulesTree itemAtPath:
		                          self presenter rulesTree selection
			                          selectedPath allButLast.
	            parentRule removeStyleRule: aToStyleRule.
	            self updateSelectionAfterRemoving ].
self removeWithBlock:okAction
	
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> selectedRuleChanged: aToStyleRule [

	self presenter updatePresenterOnlyButtons.
	self isTriggerSelectedRuleChanged ifFalse: [ ^ self ].
	self observers do: [ :each | each selectedRuleChanged: aToStyleRule ]
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> theme: aToTheme [

	self presenter rulesTree roots: { aToTheme }.
	self presenter updatePresenter.
	self presenter rulesTree selectItem: aToTheme.
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> updateSelectionAfterAdding: aToStyleRule [

	| previousSelectedRule previousPath newPath |
	previousSelectedRule := self presenter rulesTree selectedItem.
	previousPath := self presenter rulesTree selection selectedPath.

	newPath := previousPath
	           ,
	           { (previousSelectedRule styleRules indexOf: aToStyleRule) }.

	self updateSelectionOnPath: newPath.
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> updateSelectionAfterRemoving [

	| newPath |
	newPath := self presenter rulesTree selection selectedPath allButLast.
	self updateSelectionOnPath: newPath
]

{ #category : #adding }
ToThemeEditorRulesTreeController >> updateSelectionOnPath: aPath [.

	self doNotTriggerSelectedRuleChangedWhile: [
		self presenter updatePresenter ].
	self presenter rulesTree selectPath: aPath scrollToSelection: true
]
