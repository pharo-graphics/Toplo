Class {
	#name : #ToThemeInspectorSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'styleRuleTree',
		'scrollSection'
	],
	#category : #'Toplo-IDE'
}

{ #category : #accessing }
ToThemeInspectorSpec >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: self styleRuleTree;
		  add: self scrollSection;
		  yourself
]

{ #category : #'initialization - deprecated' }
ToThemeInspectorSpec >> initializePresenter [

	styleRuleTree := SpTreePresenter new
		                 children: [ :aStyleRule | aStyleRule styleRules ];
		                 whenSelectedItemChangedDo: [ :aStyleRule |
			                 self selectedItemInTreeChanged: aStyleRule ];
		displayBold: [ :aStyleRule | self shouldDisplayBoldFor: aStyleRule ];
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
ToThemeInspectorSpec >> scrollSection [

	^ scrollSection
]

{ #category : #'as yet unclassified' }
ToThemeInspectorSpec >> selectedItemInTreeChanged: aStyleRule [

	| path arrayOfRules arrayOfSpecRules layoutForRules |
	path := self styleRuleTree selection selectedPath.
	path ifEmpty: [ ^ self ].
	arrayOfRules := self styleRuleTree pathItemOf: path.

	arrayOfSpecRules := arrayOfRules collect: [ :each |
		                    ToStyleRuleInspectorSpec
			                                          new
			                                          styleRule: each;
			                                          yourself.
		                    ].
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
ToThemeInspectorSpec >> shouldDisplayBoldFor: aStyleRule [

	| path arrayOfRules |
	path := self styleRuleTree selection selectedPath.
	path ifEmpty: [ ^ false ].
	arrayOfRules := self styleRuleTree pathItemOf: path.
	^ arrayOfRules includes: aStyleRule
]

{ #category : #accessing }
ToThemeInspectorSpec >> styleRuleTree [

	^ styleRuleTree.
]

{ #category : #'t - style rules holder' }
ToThemeInspectorSpec >> styleRules: aCollection [

	self styleRuleTree roots: aCollection
]
