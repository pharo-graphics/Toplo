Class {
	#name : #ToStyleRulesInspectorSpec,
	#superclass : #ToSpaceThemeSkinForElementComplementSpec,
	#instVars : [
		'styleRuleTree',
		'scrollSection',
		'skin',
		'element'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #accessing }
ToStyleRulesInspectorSpec >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: self styleRuleTree;
		  add: self scrollSection;
		  yourself
]

{ #category : #accessing }
ToStyleRulesInspectorSpec >> element [
	^ element
]

{ #category : #accessing }
ToStyleRulesInspectorSpec >> element: aBlElement [

	element:= aBlElement
]

{ #category : #'initialization - deprecated' }
ToStyleRulesInspectorSpec >> initializePresenter [

	styleRuleTree := SpTreePresenter new
		                 children: [ :aStyleRule | aStyleRule styleRules ];
		                 whenSelectedItemChangedDo: [ :aStyleRule |
			                 self selectedItemInTreeChanged: aStyleRule ];
		                 displayBold: [ :aStyleRule |
			                 self shouldDisplayBoldFor: aStyleRule ];
		                 displayIcon: [ :aStyleRule |
			                 self shouldDisplayIconFor: aStyleRule ];
		                 display: [ :aStyleRule |
			                 | printer |
			                 printer := ToSelectorPrinter new.
			                 aStyleRule selector accept: printer.
			                 printer contents ];
		                 expandAll;
		                 yourself.
	scrollSection := SpScrollableLayout new
		                 child: (SpLabelPresenter new
				                  label: '???';
				                  yourself);
		                 yourself
]

{ #category : #accessing }
ToStyleRulesInspectorSpec >> scrollSection [

	^ scrollSection
]

{ #category : #'as yet unclassified' }
ToStyleRulesInspectorSpec >> selectedItemInTreeChanged: aStyleRule [

	| path arrayOfRules arrayOfSpecRules layoutForRules |
	path := self styleRuleTree selection selectedPath.
	path ifEmpty: [ ^ self ].
	arrayOfRules := self styleRuleTree pathItemOf: path.

	arrayOfSpecRules := arrayOfRules collect: [ :each |
		                    ToStyleRuleInspectorSpec new
			                    styleRule: each;
			                    element: self element;
			                    skin: self skin;
			                    yourself ].
	layoutForRules := SpBoxLayout newVertical.
	arrayOfSpecRules reverseDo: [ :each |
		layoutForRules
			add: each
			height: 60 + (each styleRule lookEventListeners size * 24) ].
	self scrollSection child: (SpPresenter new
			 layout: layoutForRules;
			 yourself)
]

{ #category : #'as yet unclassified' }
ToStyleRulesInspectorSpec >> shouldDisplayBoldFor: aStyleRule [

	| path arrayOfRules |
	path := self styleRuleTree selection selectedPath.
	path ifEmpty: [ ^ false ].
	arrayOfRules := self styleRuleTree pathItemOf: path.
	^ arrayOfRules includes: aStyleRule
]

{ #category : #'as yet unclassified' }
ToStyleRulesInspectorSpec >> shouldDisplayIconFor: aStyleRule [

	self skin ifNotNil: [
		(aStyleRule lookEventListeners includesAny:
			 self skin lookEventListeners) ifTrue: [
			^ self iconNamed: #smallOk ] ].
	self element ifNotNil: [
		(ToSelectorInterpreter new
			 check: aStyleRule selector
			 on: self element) ifTrue: [ ^ self iconNamed: #protocolProtected ] ].
	^ self iconNamed: #smallCancel
]

{ #category : #'as yet unclassified' }
ToStyleRulesInspectorSpec >> skin [
	^ skin
]

{ #category : #accessing }
ToStyleRulesInspectorSpec >> skin: aSkin [

	(aSkin isKindOf: ToStyleSheetSkin) ifFalse: [ ^ self ].
	skin := aSkin.
	self styleRuleTree refresh
]

{ #category : #accessing }
ToStyleRulesInspectorSpec >> styleRuleTree [

	^ styleRuleTree.
]

{ #category : #'t - style rules holder' }
ToStyleRulesInspectorSpec >> styleRules: aCollection [

	self styleRuleTree roots: aCollection
]
