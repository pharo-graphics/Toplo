Extension { #name : #ToStyleSheetTheme }

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionStyleRules: aBuilder [

	<inspectorPresentationOrder: 1 title: 'Style Rules'>
	^ ToStyleSheetThemeInspectorSpec new styleSheetTheme:
		  self
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionTokens: aBuilder [

	<inspectorPresentationOrder: 31 title: 'Theme Tokens'>
	| table |
	table := SpTablePresenter new
		         items: self defaultTokenProperties;
		         sortingBlock: [ :a :b | a name < b name ];
		         addColumn:
			         (SpStringTableColumn
				          title: 'Name'
				          evaluated: [ :each | each name ]);
		         addColumn:
			         (SpStringTableColumn
				          title: 'Value'
				          evaluated: [ :each | each value ]);
		         yourself.

	table contextMenu: (SpMenuPresenter new
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect the token';
					 action: [ table selectedItem inspect ] ];
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect the token value';
					 action: [ table selectedItem value inspect ] ]).

	^ table
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionWritableProperties: aBuilder [

	<inspectorPresentationOrder: 3 title: 'Writable Properties'>
	| table |
	table := SpTablePresenter new
		  items: self styleSheet rawWritablePropertyIndex index associations;
		  sortingBlock: [ :a :b | a key < b key ];
		  addColumn:
			  (SpStringTableColumn
				   title: 'Name'
				   evaluated: [ :each | each key ]);
		  addColumn:
			  (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each value ]);
		  yourself.
	table contextMenu: (SpMenuPresenter new
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect the property';
					 action: [ table selectedItem inspect ] ]).
		
	^ table
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> specializationPresenter [

	^ ToStyleSheetThemeSpecializationPresenter new theme: self; yourself.
]
