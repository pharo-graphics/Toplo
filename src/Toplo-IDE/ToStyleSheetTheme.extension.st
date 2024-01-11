Extension { #name : #ToStyleSheetTheme }

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionStyleRules [

	<inspectorPresentationOrder: 1 title: 'Style Rules'>
	^ ToStyleSheetThemeInspectorSpec new styleSheetTheme:
		  self
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionTheme [
	^ ToStyleSheetThemeSpec new toTheme: self
	
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionThemeForElement [

	^ ToSkinThemeSpec new
		  complementView: self inspectionStyleRules;
		  yourself
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetTheme >> inspectionThemeWithSkin [

	^ ToStyleSheetThemeSpecWithSkin new toTheme: self
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
ToStyleSheetTheme >> inspectionWritableProperties [

	<inspectorPresentationOrder: 3 title: 'Writable Properties'>
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
