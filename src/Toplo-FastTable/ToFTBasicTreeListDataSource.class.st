"
Simple tree list data source.

For example usage see methods on the class side under the protocol ""examples"". 


"
Class {
	#name : #ToFTBasicTreeListDataSource,
	#superclass : #ToFTDataSource,
	#instVars : [
		'childrenBlock',
		'displayBlock',
		'sortingBlock',
		'availableRows',
		'rootItems'
	],
	#category : #'Toplo-FastTable-Tree-Basic'
}

{ #category : #examples }
ToFTBasicTreeListDataSource class >> exampleBasicInspect: anObject [
	<sampleInstance>

	| ds ft |

	ds := ToFTBasicTreeListDataSource new .

	ds	root: #ROOT->anObject;
		children: [ :item | item value gtInspectorVariableValuePairs ];
		sortChildrenBy: [ :a :b | a key asString <= b key asString ];
		display: [ :item :cell | cell addMorphBack: item printString asMorph ];
		yourself.

	ft := ToFTTableElement new
		extent: 600@500;
		dataSource: ds.

	ft openInWindow position: 20@10.

	^ds
]

{ #category : #examples }
ToFTBasicTreeListDataSource class >> exampleInspect: anObject [
	<sampleInstance>

	| ds ft |

	ds := ToFTBasicTreeListDataSource new .

	ds	root: #ROOT->anObject;
		children: [ :item | item value gtInspectorVariableValuePairs ];
		sortChildrenBy: [ :a :b | a key asString <= b key asString ];
		display: [ :item :cell | cell
			addMorphBack: (self iconNamed: item value systemIconName) asMorph;
			addMorphBack: (item key asStringMorph emphasis: 1; yourself);
			addMorphBack: (Morph new color: Color transparent; height: 1; width: 10; yourself);
			addMorphBack: item value asStringMorph ];
		yourself.

	ds expand: 1.

	ft := ToFTTableElement new
		extent: 800@500;
		dataSource: ds.

	ft openInWindow position: 20@10.

	^ds
]

{ #category : #examples }
ToFTBasicTreeListDataSource class >> exampleProtoObjectClassTree [

	| ds ft |

	ds := ToFTBasicTreeListDataSource new
		root: ProtoObject;
		children: [ :item | item subclasses ];
		sortChildrenBy: [ :a :b | a name <= b name ];
		display: [ :item :cell | cell addMorphBack: item printString asMorph ];
		yourself.

	ft := ToFTTableElement new
		extent: 200@200;
		dataSource: ds.

	ft openInWindow position: 20@10
]

{ #category : #examples }
ToFTBasicTreeListDataSource class >> exampleSomeClassesSubclassesTree [

	| ds ft |

	ds := ToFTBasicTreeListDataSource new
		roots: { ToFTDataSource . String . Boolean } ;
		children: [ :item | item subclasses ];
		sortChildrenBy: [ :a :b | a methods size <= b methods size ];
		display: [ :item :cell | cell addMorphBack: (item name asString , ' (' , item methods size asString , ')') asMorph ];
		yourself.

	ft := ToFTTableElement new
		extent: 200@200;
		dataSource: ds.

	ft openInWindow position: 20@10
]

{ #category : #examples }
ToFTBasicTreeListDataSource class >> exampleStateTree [

	| ds ft |

	ds := ToFTBasicTreeListDataSource new .

	ds	roots: { #self -> ds } ;
		children: [ :item | item value gtInspectorVariableValuePairs ];
		sortChildrenBy: [ :a :b | a key asString <= b key asString ];
		display: [ :item :cell | cell
			addMorphBack: (self iconNamed: item value systemIconName) asMorph;
			addMorphBack: (item key printString asMorph emphasis: 1; yourself);
			addMorphBack: (Morph new color: Color transparent; height: 1; width: 10; yourself);
			addMorphBack: (item value printString) asMorph ];
		yourself.

	ds expand: 3.

	ft := ToFTTableElement new
		extent: 600@500;
		dataSource: ds.

	ft openInWindow position: 20@10
]

{ #category : #examples }
ToFTBasicTreeListDataSource class >> exampleWorldSubmorphTree [

	| ds ft |

	ds := ToFTBasicTreeListDataSource new
		root: self currentWorld;
		children: [ :item | item submorphs ];
		expand: 2;
		display: [ :item :cell | cell addMorphBack: item printString asMorph ];
		yourself.

	ft := ToFTTableElement new
		extent: 400@500;
		dataSource: ds.

	ft openInWindow position: 20@10
]

{ #category : #accessing }
ToFTBasicTreeListDataSource >> cellColumn: column row: rowIndex [
	| item |

	"this is a bad way for tree; maybe list too. the morph should ask for the full collection from index start to n elements.
	eps when elementAt: must traverse the tree to find each element: not only a basic at:
	"
	item := self dataAt: rowIndex.

	^item cellMorphFor: self
]

{ #category : #construction }
ToFTBasicTreeListDataSource >> children: aBlock [

	"aBlock -> [ :item | aCollection ]"

	childrenBlock := aBlock
]

{ #category : #accessing }
ToFTBasicTreeListDataSource >> childrenBlock [

	^childrenBlock
]

{ #category : #accessing }
ToFTBasicTreeListDataSource >> childrenFor: anItem [

	| children |

	children := (childrenBlock value: anItem).

	^sortingBlock ifNil: [ children ] ifNotNil: [ children sort: sortingBlock ]
]

{ #category : #private }
ToFTBasicTreeListDataSource >> countAvailableRows [

	availableRows := rootItems inject: 0 into: [ :sum :item | sum + item availableRows ]
]

{ #category : #private }
ToFTBasicTreeListDataSource >> dataAt: index [
	| curr b |

	curr := 0.

	b := nil.
	b := [ :p | p do: [ :each | (curr := curr + 1) = index ifTrue: [ ^each ] ifFalse: [ b value: each children ] ] ].

	b value: rootItems.

	SubscriptOutOfBounds signal: index
]

{ #category : #construction }
ToFTBasicTreeListDataSource >> display: aBlock [

	"aBlock -> [ :item :cell | cell addMorphBack: ... ]"

	displayBlock := aBlock
]

{ #category : #accessing }
ToFTBasicTreeListDataSource >> displayBlock [

	^displayBlock
]

{ #category : #'expanding-collapsing' }
ToFTBasicTreeListDataSource >> expand: aNumber [

	rootItems do: [ :each | each expandToDepth: aNumber ]
]

{ #category : #'expanding-collapsing' }
ToFTBasicTreeListDataSource >> expandAll [

	self expand: SmallInteger maxVal
]

{ #category : #accessing }
ToFTBasicTreeListDataSource >> numberOfRows [

	^availableRows
]

{ #category : #construction }
ToFTBasicTreeListDataSource >> root: anObject [

	self roots: { anObject }
]

{ #category : #construction }
ToFTBasicTreeListDataSource >> roots: aCollection [

	rootItems := aCollection collect: [ :each |
			ToFTBasicTreeListItem new
				item: each;
				datasource: self
	].

	self countAvailableRows
]

{ #category : #construction }
ToFTBasicTreeListDataSource >> sortChildrenBy: aBlock [

	"aBLock -> [ :a :b | a something <= b something ] "

	sortingBlock := aBlock
]

{ #category : #private }
ToFTBasicTreeListDataSource >> tableRefresh [
	table ifNotNil: [ table refresh ]
]

{ #category : #private }
ToFTBasicTreeListDataSource >> updateAvailableRows: aNumber [


	availableRows := availableRows + aNumber.

	aNumber isZero ifFalse: [ self tableRefresh ]
]
