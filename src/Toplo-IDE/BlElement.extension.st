Extension { #name : #BlElement }

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionSkin: aBuilder [

	<inspectorPresentationOrder: 30 title: 'Skin'>
	self skinManager ifNil: [
		^ ToSkinNoSkinManagerPresenter new
			  element: self;
			  yourself ].
	^ ToSkinWithSkinManagerPresenter new
		  element: self;
		  yourself
]

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionStamps: aBuilder [

	<inspectorPresentationOrder: 30 title: 'Stamps'>
	| table |
	table := SpTablePresenter new
		  items: (self stampIndex
				   ifNil: [ #(  ) ]
				   ifNotNil: [ :map | map stampIndex allProperties ]);
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
					 name: 'Inspect the stamp';
					 action: [ table selectedItem inspect ] ];
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect the stamp value';
					 action: [ table selectedItem value value inspect ] ]).

	^ table
]

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionTokens: aBuilder [

	<inspectorPresentationOrder: 31 title: 'Tokens'>
	| table |
	table := SpTablePresenter new
		  items: (self tokenPropertyIndex
				   ifNil: [ #(  ) ]
				   ifNotNil: [ :idx | idx allProperties ]);
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
					 name: 'Inspect the token';
					 action: [ table selectedItem inspect ] ];
			 addItem: [ :item |
				 item
					 icon: (self iconNamed: #smallInspectIt);
					 name: 'Inspect the token value';
					 action: [ table selectedItem value value inspect ] ]).
	^ table
]

{ #category : #'*Toplo-IDE' }
BlElement >> styleSheetRulesCount: aBuilder [

	self skinManagerDo: [ :skinManager |
		skinManager installedSkinDo: [ :skin |
			^ skin styleSheetRulesCount ] ].
	^ 0
]
