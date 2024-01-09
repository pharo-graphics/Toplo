Class {
	#name : #ToStyleRuleInspectorSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'selectorLabel',
		'inspectButton',
		'propertiesTable',
		'styleRule',
		'model'
	],
	#category : #'Toplo-IDE'
}

{ #category : #layout }
ToStyleRuleInspectorSpec >> defaultLayout [

	^ SpBoxLayout newVertical
	spacing: 4;
		  add: (SpBoxLayout newHorizontal
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
ToStyleRuleInspectorSpec >> selectorLabel [

	^ selectorLabel
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

	self propertiesTable lookEventListeners: aStyleRule lookEventListeners.
	self selectorLabel label: printer contents
]
