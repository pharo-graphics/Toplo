Extension { #name : #BlElement }

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionStamps [

	<inspectorPresentationOrder: 30 title: 'Stamps'>
	| items table |
	items := self toStyleStore
		         ifNotNil: [ :store | store stampIndex allProperties ]
		         ifNil: [ {  } ].
	table := SpTablePresenter new
		         items: items;
		         sortingBlock: [ :a :b | a key < b key ];
		         addColumn:
			         (SpStringTableColumn
				          title: 'Name'
				          evaluated: [ :each | each key ]);
		         addColumn: (SpStringTableColumn
				          title: 'Value'
				          evaluated: [ :each | each value value ]);
		         yourself.
	table contextMenu: (SpMenuPresenter new
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect stamp';
					 action: [ table selectedItem value inspect ] ];
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect value';
					 action: [ table selectedItem value value inspect ] ];
			 yourself).
	^ table
]

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionTokens [

	<inspectorPresentationOrder: 31 title: 'Tokens'>
	| items table |
	items := self toStyleStore
		         ifNotNil: [ :store |
		         store tokenPropertyIndex allProperties ]
		         ifNil: [ {  } ].

	table := SpTablePresenter new
		         items: items;
		         sortingBlock: [ :a :b | a key < b key ];
		         addColumn:
			         (SpStringTableColumn
				          title: 'Name'
				          evaluated: [ :each | each key ]);
		         addColumn: (SpStringTableColumn
				          title: 'Value'
				          evaluated: [ :each | each value value ]);
		         yourself.
	table contextMenu: (SpMenuPresenter new
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect token';
					 action: [ table selectedItem value inspect ] ];
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect value';
					 action: [ table selectedItem value value inspect ] ];
			 yourself).
	^ table
]

{ #category : #'*Toplo-IDE' }
BlElement >> styleSheetRulesCount [

	(self userData at: #skinManager ifAbsent: []) ifNotNil: [ :skinManager |
		skinManager installedSkinDo: [ :skin |
			^ skinManager installedSkin styleSheetRulesCount ] ].
	^ 0
]
