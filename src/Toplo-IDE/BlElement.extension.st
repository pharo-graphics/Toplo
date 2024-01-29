Extension { #name : #BlElement }

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionStamps [

	<inspectorPresentationOrder: 30 title: 'Stamps'>
	^ SpTablePresenter new
		  items: self toStyleStore stampIndex allProperties;
		  sortingBlock: [ :a :b | a key < b key ];
		  addColumn:
			  (SpStringTableColumn
				   title: 'Name'
				   evaluated: [ :each | each key ]);
		  addColumn:
			  (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each value ]);
		  yourself
]

{ #category : #'*Toplo-IDE' }
BlElement >> inspectionTokens [

	<inspectorPresentationOrder: 31 title: 'Tokens'>

	^ SpTablePresenter new
		  items:(self toStyleStore tokenPropertyIndex allProperties);
		  sortingBlock: [ :a :b | a key < b key ];
		  addColumn:
			  (SpStringTableColumn
				   title: 'Name'
				   evaluated: [ :each | each key ]);
		  addColumn:
			  (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each | each value ]);
		  yourself
]

{ #category : #'*Toplo-IDE' }
BlElement >> styleSheetRulesCount [

	(self userData at: #skinManager ifAbsent: []) ifNotNil: [ :skinManager |
		skinManager installedSkinDo: [ :skin |
			^ skinManager installedSkin styleSheetRulesCount ] ].
	^ 0
]
