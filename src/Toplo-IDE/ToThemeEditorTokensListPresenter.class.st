Class {
	#name : #ToThemeEditorTokensListPresenter,
	#superclass : #SpPresenter,
	#traits : 'TToThemeEditorPresenterWithButtons',
	#classTraits : 'TToThemeEditorPresenterWithButtons classTrait',
	#instVars : [
		'tokensList'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-themeInfos'
}

{ #category : #accessing }
ToThemeEditorTokensListPresenter >> actionAddButton [

	self controller addToken
]

{ #category : #accessing }
ToThemeEditorTokensListPresenter >> actionRemoveButton [

	self controller removeToken: self tokensList selectedItem
]

{ #category : #accessing }
ToThemeEditorTokensListPresenter >> controllerClass [

	^ ToThemeEditorTokensListController
]

{ #category : #layout }
ToThemeEditorTokensListPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: self tokensList expand: true;
		  add: self buttonsLayout expand: false;
		  yourself
]

{ #category : #initialization }
ToThemeEditorTokensListPresenter >> initializePresenters [

	tokensList := SpTablePresenter new
		              isResizable: true;
		              contextMenu: self tokenMenu;
		whenSelectedItemChangedDo: [ :item | self updatePresenter ];
		              yourself.
	tokensList addColumn:
		((SpStringTableColumn
			  title: 'Token'
			  evaluated: [ :each | each name ]) sortFunction:
			 [ :each | each name ] ascending).
	tokensList addColumn: ((SpStringTableColumn
			  title: 'Type'
			  evaluated: [ :each | each value class name ]) sortFunction:
			 [ :each | each value class name ] ascending).
	tokensList addColumn:
		((SpStringTableColumn title: 'Value' evaluated: [ :each |
			  each value isColor
				  ifTrue: [
					  | hex |
					  hex := each value asHexString.
					  each value alpha ~= 1 ifTrue: [
						  hex := hex , ' alpha: ' , each value alpha printString ].
					  hex ]
				  ifFalse: [ each value printString ] ]) sortFunction: [ :each |
			 each value isColor
				 ifTrue: [
					 | hex |
					 hex := each value asHexString.
					 each value alpha ~= 1 ifTrue: [
						 hex := hex , ' alpha: ' , each value alpha printString ].
					 '  ~  ' , hex ]
				 ifFalse: [ each value printString ] ] ascending).
	tokensList addColumn:
		((SpImageTableColumn title: '' evaluated: [ :each |
			  each value isColor
				  ifTrue: [
					  Morph new
						  extent: 16 @ 16;
						  color: each value;
						  asForm ]
				  ifFalse: [ nil ] ]) width: 20)
]

{ #category : #'as yet unclassified' }
ToThemeEditorTokensListPresenter >> tokenMenu [

	^ SpMenuPresenter new
		  addItem: [ :item |
			  item
				  icon: (self iconNamed: #smallInspectIt);
				  name: 'Inspect';
				  action: [ self tokensList selectedItem inspect ];
				  yourself ];
		  addItem: [ :item |
			  item
				  icon: (self iconNamed: #smallCopy);
				  name: 'Copy for property writer';
				  action: [
					  Clipboard clipboardText:
							  '(e valueOfTokenNamed: #''' , self tokensList selectedItem name
							  , ''')' ];
				  yourself ];
		  yourself
]

{ #category : #accessing }
ToThemeEditorTokensListPresenter >> tokensList [

	^ tokensList
]

{ #category : #initialization }
ToThemeEditorTokensListPresenter >> updatePresenter [

	self updatePresenterOnlyButtons
]
