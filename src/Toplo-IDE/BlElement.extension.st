Extension { #name : #BlElement }

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionStamps [

	<inspectorPresentationOrder: 30 title: 'Stamps'>
	| items |
	items := self toStyleStore
		         ifNotNil: [ :store | store stampIndex allProperties ]
		         ifNil: [ {  } ].

	^ SpTablePresenter new
		  items: items;
		  sortingBlock: [ :a :b | a key < b key ];
		  addColumn:
			  (SpStringTableColumn
				   title: 'Name'
				   evaluated: [ :each | each key ]);
		  addColumn:
			  (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each value value ]);
		  yourself
]

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionTokens [

	<inspectorPresentationOrder: 31 title: 'Tokens'>
	| items |
	items := self toStyleStore
		         ifNotNil: [ :store |
		         store tokenPropertyIndex allProperties ]
		         ifNil: [ {  } ].

	^ SpTablePresenter new
		  items: items;
		  sortingBlock: [ :a :b | a key < b key ];
		  addColumn:
			  (SpStringTableColumn
				   title: 'Name'
				   evaluated: [ :each | each key ]);
		  addColumn:
			  (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each value value ]);
		  yourself
]

{ #category : #'*Toplo-IDE' }
BlElement >> styleSheetRulesCount [

	(self userData at: #skinManager ifAbsent: []) ifNotNil: [ :skinManager |
		skinManager installedSkinDo: [ :skin |
			^ skinManager installedSkin styleSheetRulesCount ] ].
	^ 0
]
