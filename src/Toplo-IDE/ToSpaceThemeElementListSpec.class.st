Class {
	#name : #ToSpaceThemeElementListSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'tree',
		'elementsTree'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #column }
ToSpaceThemeElementListSpec class >> nameColumn [

	| column |
	column := SpStringTableColumn
		          title: 'Name'
		          evaluated: [ :element | element printString ].
	column
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

	^ column
]

{ #category : #column }
ToSpaceThemeElementListSpec class >> rulesCountColumn [

	^ (SpStringTableColumn title: 'Rules' evaluated: [ :element |
		   element styleSheetRulesCount = 0
			   ifTrue: [ '' ]
			   ifFalse: [ element styleSheetRulesCount printString ].
		   ]) width: 50
]

{ #category : #column }
ToSpaceThemeElementListSpec class >> stampsCountColumn [

	^ (SpStringTableColumn title: 'Stamps' evaluated: [ :element |
		   element toStyleStore allStamps size = 0
			   ifTrue: [ '' ]
			   ifFalse: [ element toStyleStore allStamps size ] ]) width: 50
]

{ #category : #column }
ToSpaceThemeElementListSpec class >> tokenIconColumn [

	| aToSpaceThemeElementListSpec |
	aToSpaceThemeElementListSpec := self new.

	^ (SpImageTableColumn title: 'Token' evaluated: [ :element |
		   element toStyleStore tokenPropertyIndex size = 0
			   ifTrue: [ aToSpaceThemeElementListSpec iconNamed: #blank ]
			   ifFalse: [ aToSpaceThemeElementListSpec iconNamed: #smallOk ] ])
		  width: 50
]

{ #category : #column }
ToSpaceThemeElementListSpec class >> visibilityColumn [

	| aToSpaceThemeElementListSpec |
	aToSpaceThemeElementListSpec := self new.

	^ (SpImageTableColumn title: 'Visible' evaluated: [ :element |
		   element isVisible
			   ifTrue: [ aToSpaceThemeElementListSpec iconNamed: #smallOk ]
			   ifFalse: [ aToSpaceThemeElementListSpec iconNamed: #blank ] ])
		  width: 50
]

{ #category : #layout }
ToSpaceThemeElementListSpec >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: 'Elements in the space' expand: false;
		  add: self elementsTree expand: true;
		  yourself
]

{ #category : #accessing }
ToSpaceThemeElementListSpec >> elementsTree [

	^ elementsTree
]

{ #category : #initialization }
ToSpaceThemeElementListSpec >> initializePresenters [

	elementsTree := SpTreeTablePresenter new
		                children: [ :element | element children ];
		                yourself
]

{ #category : #accessing }
ToSpaceThemeElementListSpec >> root: aBlElement [

	self elementsTree roots: { aBlElement }
]

{ #category : #enumerating }
ToSpaceThemeElementListSpec >> whenSelectionChangedDo: aBlock [

	self elementsTree whenSelectedItemChangedDo: aBlock
]
