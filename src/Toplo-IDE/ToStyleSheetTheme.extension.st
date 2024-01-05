Extension { #name : #ToStyleSheetTheme }

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionStyleRule [

	<inspectorPresentationOrder: 1 title: 'Style Rules'>
	^ ToThemeInspectorSpec new styleRules: self styleSheet styleRules
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionTokens [

	<inspectorPresentationOrder: 2 title: 'Tokens'>
	| tokens variantTokens |
	tokens := (self defaultTokenProperties collect: [ :each |
		           each name -> each value ]) asDictionary.
	variantTokens := (self variant class changedTokenProperties collect: [
		                  :each | each name -> each value ]) asDictionary.
	tokens addAll: variantTokens.
	^ SpTablePresenter new
		  items: tokens associations;
		sortingBlock: [ :a :b | a key < b key];
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
ToStyleSheetTheme >> inspectionWrittableProperties [

	<inspectorPresentationOrder: 3 title: 'Writtable Properties'>
	^ SpTablePresenter new
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
		  yourself
]
