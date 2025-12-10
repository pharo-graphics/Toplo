Class {
	#name : #ToSpaceThemeElementSelectorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'tree',
		'elementsTree'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #column }
ToSpaceThemeElementSelectorPresenter class >> nameColumn [

	| columnName  |
	columnName := SpStringTableColumn
		              title: 'Name'
		              evaluated: [ :element | element printString ].


	columnName
		displayColor: [ :element |
			element userData
				at: #skinManager
				ifPresent: [ :skinManager |
					skinManager installedSkin
						ifNil: [ Smalltalk ui theme dangerTextColor ]
						ifNotNil: [ skinManager installedSkin inspectorDisplayColor ] ]
				ifAbsent: [ Smalltalk ui theme dangerTextColor ] ];
		displayItalic: [ :element |
			| result |
			result := false.
			element userData
				at: #skinManager
				ifPresent: [ :skinManager |
					skinManager installedSkin ifNotNil: [
							result := skinManager installedSkin isKindOf: ToStyleSheetSkin ] ]
				ifAbsent: [ Smalltalk ui theme dangerTextColor ].
			result not ].

	^ columnName
]

{ #category : #column }
ToSpaceThemeElementSelectorPresenter class >> rulesCountColumn [

	^ (SpStringTableColumn title: 'Rules' evaluated: [ :element |
		   element styleSheetRulesCount = 0
			   ifTrue: [ '' ]
			   ifFalse: [ element styleSheetRulesCount printString ].
		   ]) width: 50
]

{ #category : #column }
ToSpaceThemeElementSelectorPresenter class >> stampsCountColumn [

	^ (SpStringTableColumn title: 'Stamps' evaluated: [ :element |
		 element stampMap ifNil: [ '' ] ifNotNil: [  
		   element stampMap allStamps size = 0
			   ifTrue: [ '' ]
			   ifFalse: [ element stampMap allStamps size ] ]]) width: 50
]

{ #category : #column }
ToSpaceThemeElementSelectorPresenter class >> themeColumn [

	| columnMain columnTheme columnInherits |
	columnMain := SpCompositeTableColumn new
		              title: 'Theme';
		              yourself.
	columnTheme := SpStringTableColumn
		               title: 'Theme'
		               evaluated: [ :element |
		               '[' , element lookupTheme name , '] ' ].
	columnInherits := SpImageTableColumn
		                  title: 'Inherits theme'
		                  evaluated: [ :element |
			                  element userData
				                  at: #localTheme
				                  ifPresent: [ nil ]
				                  ifAbsent: [ self iconNamed: #arrowUp ] ].
	columnMain addColumn: columnInherits.
	columnMain addColumn: columnTheme.
	columnMain width: 150.
	
	columnTheme displayBold: [ :element | element userData includesKey: #localTheme ].

	^ columnMain
]

{ #category : #column }
ToSpaceThemeElementSelectorPresenter class >> tokenIconColumn [

	| aToSpaceThemeElementListSpec |
	aToSpaceThemeElementListSpec := self new.

	^ (SpImageTableColumn title: 'Token' evaluated: [ :element |
		   element tokenPropertyMap ifNil: [ aToSpaceThemeElementListSpec iconNamed: #blank ] ifNotNil: [  
		   element tokenPropertyMap size = 0
			   ifTrue: [ aToSpaceThemeElementListSpec iconNamed: #blank ]
			   ifFalse: [ aToSpaceThemeElementListSpec iconNamed: #smallOk ] ] ])
		  width: 50
]

{ #category : #column }
ToSpaceThemeElementSelectorPresenter class >> visibilityColumn [

	| aToSpaceThemeElementListSpec |
	aToSpaceThemeElementListSpec := self new.

	^ (SpImageTableColumn title: 'Visible' evaluated: [ :element |
		   element isVisible
			   ifTrue: [ aToSpaceThemeElementListSpec iconNamed: #smallOk ]
			   ifFalse: [ aToSpaceThemeElementListSpec iconNamed: #blank ] ])
		  width: 50
]

{ #category : #api }
ToSpaceThemeElementSelectorPresenter >> columns: aCollection [

	self elementsTree columns: aCollection
]

{ #category : #layout }
ToSpaceThemeElementSelectorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: 'Elements in the space' expand: false;
		  add: self elementsTree expand: true;
		  yourself
]

{ #category : #accessing }
ToSpaceThemeElementSelectorPresenter >> elementsTree [

	^ elementsTree
]

{ #category : #initialization }
ToSpaceThemeElementSelectorPresenter >> initializePresenters [

	elementsTree := SpTreeTablePresenter new
		                children: [ :element | element children ];
		                contextMenu: (SpMenuPresenter new
				                 addItem: [ :item |
					                 item
						                 icon: (self iconNamed: #smallInspectIt);
						                 name: 'Inspect selected element';
						                 action: [ self elementsTree selectedItem inspect ];
						                 yourself ];
				                 yourself);
		                yourself
]

{ #category : #accessing }
ToSpaceThemeElementSelectorPresenter >> root: aBlElement [

	self elementsTree roots: { aBlElement }
]

{ #category : #initialization }
ToSpaceThemeElementSelectorPresenter >> updatePresenter [

	self elementsTree refresh
]

{ #category : #enumerating }
ToSpaceThemeElementSelectorPresenter >> whenSelectionChangedDo: aBlock [

	self elementsTree whenSelectedItemChangedDo: aBlock
]
