Class {
	#name : #ToStyleSheetThemeInspectorSpec,
	#superclass : #ToStyleSheetThemeExtensionSpec,
	#instVars : [
		'styleRuleTree',
		'scrollSection',
		'withLegend'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #'as yet unclassified' }
ToStyleSheetThemeInspectorSpec >> createStyleRuleSpecFor: aStyleRule [

	^ ToStyleRuleInspectorSpec new
		  element: self element;
		  skin: self skin;
		styleRule: aStyleRule;
		  yourself
]

{ #category : #accessing }
ToStyleSheetThemeInspectorSpec >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: self styleRuleTree;
		  add: self scrollSection;
		  yourself
]

{ #category : #'initialization - deprecated' }
ToStyleSheetThemeInspectorSpec >> initializePresenter [

	withLegend := false.
	styleRuleTree := SpTreePresenter new
		                 children: [ :aStyleRule | aStyleRule styleRules ];
		                 whenSelectedItemChangedDo: [ :aStyleRule |
			                 self selectedItemInTreeChanged: aStyleRule ];
		                 displayBold: [ :aStyleRule |
			                 self shouldDisplayBoldFor: aStyleRule ];
		                 displayIcon: [ :aStyleRule |
			                 self iconForSelector: aStyleRule ];
		                 display: [ :aStyleRule |
			                 | printer |
			                 printer := ToSelectorPrinter new.
			                 aStyleRule selector accept: printer.
			                 printer contents ];
		                 expandAll;
		                 yourself.

	styleRuleTree contextMenu: (SpMenuPresenter new addItem: [:item | item name: 'Inspect the rule'; icon: (self iconNamed: #smallInspectIt); action: [ self styleRuleTree selectedItem inspect]]).

	scrollSection := SpScrollableLayout new
		                 child: (SpLabelPresenter new
				                  label: '<- Select a rule on the left panel.';
				                  yourself);
		                 yourself
]

{ #category : #'as yet unclassified' }
ToStyleSheetThemeInspectorSpec >> makeHelpLegend [

	| iconSet |
	iconSet := ToStyleSheetThemeExtensionSpec new.
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: iconSet skinAndStyleRuleIcon expand: false;
				   add: 'Selector is ok and rule is applied.';
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: iconSet selectorOkButNotSkin expand: false;
				   add: 'Selector is ok but rule is not applied.';
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: iconSet selectorKo expand: false;
				   add: 'Selector is ko.';
				   yourself);
		  yourself
]

{ #category : #accessing }
ToStyleSheetThemeInspectorSpec >> scrollSection [

	^ scrollSection
]

{ #category : #'as yet unclassified' }
ToStyleSheetThemeInspectorSpec >> selectedItemInTreeChanged: aStyleRule [

	| path arrayOfRules arrayOfSpecRules layoutForRules |
	path := self styleRuleTree selection selectedPath.
	path ifEmpty: [ ^ self ].
	arrayOfRules := self styleRuleTree pathItemOf: path.

	arrayOfSpecRules := arrayOfRules collect: [ :each |
		                    self createStyleRuleSpecFor: each ].
	layoutForRules := SpBoxLayout newVertical.
	arrayOfSpecRules reverseDo: [ :each |
		layoutForRules
			add: each
			height: 50 + (each styleRule skinEventListeners size * 20) ].
	self scrollSection child: (SpPresenter new
			 layout: layoutForRules;
			 yourself)
]

{ #category : #'as yet unclassified' }
ToStyleSheetThemeInspectorSpec >> shouldDisplayBoldFor: aStyleRule [

	| path arrayOfRules |
	path := self styleRuleTree selection selectedPath.
	path ifEmpty: [ ^ false ].
	arrayOfRules := self styleRuleTree pathItemOf: path.
	^ arrayOfRules includes: aStyleRule
]

{ #category : #accessing }
ToStyleSheetThemeInspectorSpec >> skin: aSkin [

	skin := aSkin.
	self styleRuleTree refresh.
]

{ #category : #accessing }
ToStyleSheetThemeInspectorSpec >> styleRuleTree [

	^ styleRuleTree.
]

{ #category : #'as yet unclassified' }
ToStyleSheetThemeInspectorSpec >> styleSheetTheme: aToStyleSheetTheme [

	self styleRuleTree roots: aToStyleSheetTheme styleSheet styleRules.
	self styleRuleTree expandRoots
]

{ #category : #accessing }
ToStyleSheetThemeInspectorSpec >> theme: aTheme [

	(aTheme isKindOf: ToStyleSheetTheme) ifTrue: [
		self styleSheetTheme: aTheme ] ifFalse: [ self styleRuleTree roots: {  } ]
]

{ #category : #accessing }
ToStyleSheetThemeInspectorSpec >> updatePresenter [

	self layout: self defaultLayout
]
