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
	propertiesTable := SpTablePresenter new
		                   beResizable;
		                   addColumn:
			                   ((SpStringTableColumn
				                     title: 'Supplement'
				                     evaluated: [ :each |
					                     each isSupplement
						                     ifTrue: [ 'True' ]
						                     ifFalse: [ 'False' ] ]) width: 80);
		                   addColumn: ((SpStringTableColumn
				                     title: 'Look Event Class'
				                     evaluated: [ :each | each eventClass name ])
				                    width: 100);
		                   addColumn: (SpStringTableColumn
				                    title: 'Property'
				                    evaluated: [ :each | each property name ]);
		                   addColumn: (SpStringTableColumn
				                    title: 'Value'
				                    evaluated: [ :each | each value printString ]);
		                   addColumn: ((SpStringTableColumn
				                     title: 'Animation'
				                     evaluated: [ :each |
					                     each animation printString ]) width: 80);
		                   yourself.
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
	
	self propertiesTable items: aStyleRule lookEventListeners.
	self selectorLabel label: printer contents
]
