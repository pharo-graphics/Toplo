"
ToFTBasicTreeListItem holds the state of a element in ToFTBasicTreeListDataSource.

Instance variables: 

|< expanded >|< Private  >|< aBoolean >[ 
	remembers if this it is currently expanded or not.
}.

|< depth >|< Private  >|< aNumber >[
	The depth of this item from the root.
 ].

< item > [  anyObject. 
	The raw item which is wrapped by this class.	
].

< children > [ aCollection.
	cache for holding currently expaned children
 ].

< dataSource > [ aFBasicTreeListDataSource
	reference to the datasource
 ].
"
Class {
	#name : #ToFTBasicTreeListItem,
	#superclass : #Object,
	#instVars : [
		'expanded',
		'depth',
		'item',
		'children',
		'dataSource'
	],
	#category : #'Toplo-FastTable-Tree-Basic'
}

{ #category : #querying }
ToFTBasicTreeListItem >> availableRows [

	^expanded ifTrue: [
		children
			inject: 1
			into: [ :sum :each | sum + each availableRows ]

	] ifFalse: [ 1 ]
]

{ #category : #accessing }
ToFTBasicTreeListItem >> cellMorphFor: aDataSource [

	| morph |

	morph := ToFTIndentedCellElement new.
	morph depthIndent: depth.

	self hasChildren
		ifTrue: [ morph addMorphBack: self generateButton ]
		ifFalse: [ morph addIndendtation: 15 ].

	dataSource displayBlock value: item value: morph.

	^morph
]

{ #category : #accessing }
ToFTBasicTreeListItem >> children [

	^children
]

{ #category : #'button-interaction' }
ToFTBasicTreeListItem >> collapseItem [

	dataSource updateAvailableRows: 1 - self availableRows.

	children := #().

	expanded := false
]

{ #category : #button }
ToFTBasicTreeListItem >> collapsedButton [

	^self defaultButton
		actionSelector: #expandItem;
		labelGraphic: Smalltalk ui theme treeUnexpandedForm;
		helpText: 'Expand Item';
		yourself
]

{ #category : #construction }
ToFTBasicTreeListItem >> datasource: aDS [

	dataSource := aDS
]

{ #category : #button }
ToFTBasicTreeListItem >> defaultButton [

	^IconicButtonMorph new
		target: self;
		color: Color transparent;
		borderWidth: 0;
		yourself
]

{ #category : #construction }
ToFTBasicTreeListItem >> depth: aNumber [

	depth := aNumber
]

{ #category : #'button-interaction' }
ToFTBasicTreeListItem >> expandItem [

	expanded := true.

	children := (dataSource childrenFor: item) collect: [ :each | self treeItemFor: each ].

	dataSource updateAvailableRows: self availableRows - 1
]

{ #category : #interaction }
ToFTBasicTreeListItem >> expandToDepth: aNumber [

	depth = aNumber ifTrue: [ ^self ].

	self expandItem.

	children do: [ :each | each expandToDepth: aNumber ]
]

{ #category : #button }
ToFTBasicTreeListItem >> expandedButton [

	^self defaultButton
		actionSelector: #collapseItem;
		labelGraphic: Smalltalk ui theme treeExpandedForm;
		helpText: 'Collapse Item';
		yourself
]

{ #category : #button }
ToFTBasicTreeListItem >> generateButton [
	^expanded
		ifTrue: [ self expandedButton ]
		ifFalse: [ self collapsedButton ]
]

{ #category : #querying }
ToFTBasicTreeListItem >> hasChildren [

	^(dataSource childrenBlock value: item) isNotEmpty
]

{ #category : #initialization }
ToFTBasicTreeListItem >> initialize [

	expanded := false.
	depth := 0.
	children := #()
]

{ #category : #accessing }
ToFTBasicTreeListItem >> item [

	^item
]

{ #category : #construction }
ToFTBasicTreeListItem >> item: anItem [

	item := anItem
]

{ #category : #'button-interaction' }
ToFTBasicTreeListItem >> treeItemFor: anItem [

	^ToFTBasicTreeListItem new
		datasource: dataSource;
		depth: depth + 1;
		item: anItem
]
