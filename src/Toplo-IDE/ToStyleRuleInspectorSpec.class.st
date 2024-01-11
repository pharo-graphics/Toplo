Class {
	#name : #ToStyleRuleInspectorSpec,
	#superclass : #ToStyleSheetThemeExtensionSpec,
	#instVars : [
		'selectorLabel',
		'inspectButton',
		'propertiesTable',
		'styleRule',
		'model',
		'selectorIcon'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToStyleRuleInspectorSpec >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpBoxLayout newHorizontal
					add: self selectorIcon withConstraints: [ :c |
					   c width: 20.
					   c height: 20 ];
				   add: self selectorLabel expand: true;
				   add: self inspectButton withConstraints: [ :c |
					   c width: 20.
					   c height: 20 ];
				   yourself)
		  expand: false;
		  add: self propertiesTable expand: true;
		  yourself
]

{ #category : #'initialization - deprecated' }
ToStyleRuleInspectorSpec >> initializePresenter [

	selectorLabel := SpLabelPresenter new.
	inspectButton := SpButtonPresenter new
		                 icon: (self iconNamed: #smallInspectIt);
		                 action: [ self styleRule inspect ];
		                 yourself.
	propertiesTable := ToLookEventListenersTableSpec new.
	selectorIcon := SpImagePresenter new image: (self iconNamed: #blank); yourself.
]

{ #category : #accessing }
ToStyleRuleInspectorSpec >> inspectButton [

	^ inspectButton
]

{ #category : #accessing }
ToStyleRuleInspectorSpec >> model [

	^ model
]

{ #category : #accessing }
ToStyleRuleInspectorSpec >> propertiesTable [

	^ propertiesTable
]

{ #category : #accessing }
ToStyleRuleInspectorSpec >> selectorIcon [

	^ selectorIcon
]

{ #category : #accessing }
ToStyleRuleInspectorSpec >> selectorLabel [

	^ selectorLabel
]

{ #category : #accessing }
ToStyleRuleInspectorSpec >> skin: anObject [

skin := anObject.
	self propertiesTable skin: anObject
]

{ #category : #'as yet unclassified' }
ToStyleRuleInspectorSpec >> styleRule [

	^ styleRule
]

{ #category : #'as yet unclassified' }
ToStyleRuleInspectorSpec >> styleRule: aStyleRule [

	| printer |
	styleRule := aStyleRule.

	printer := ToSelectorPrinter new.
	aStyleRule selector accept: printer.
	self selectorLabel label: printer contents.

	self propertiesTable lookEventListeners:
		aStyleRule lookEventListeners.
	self selectorIcon image: (self iconForSelector: aStyleRule)
]
