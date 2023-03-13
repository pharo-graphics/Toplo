"
I am a data source to diplay tree in a FastTable.

Description
-------------------------------------------------

I receive  a collection of objects and a block. 
The collection of objects will be the base of the tree.

An  alternative is to pass a ToFTRootItem to myself.

The block is use to calculate the children of the nodes. (More detail at the bottom)
Since the search in Tree is can be complex you can customize it via the #searchStrateagy:. (See Public APIʦor more info.) 

I use ToFTTreeItem to manage my elements and I am use by a ToFTFastTable.

Public API and Key Messages
-------------------------------------------------

- #roots: aCollection children: aBlock 
        A constructor to build the ToFTTreeDataSource  
	
- #maxDepth 
        Set the maxDepth to diplay on the Tree.  Roots items are at depth 0.

- #searchStrategy: 
         Can take in parameter #default, #rootsOnly, #allItems.
                #default is selected by default, it will search/filter the tree for all visible rows.       
               #rootsOnly will search/filter only the first level of the tree
               #allItems will search/filter all the Tree and open the needed items. BEʃAREFUL ! YOUʓHOULDʎOTʕSEʔHISʉFʊYOURʔREEʃANʈAVEʁNʉNFINITYʏFʃHILDREN! 

Example
-------------------------------------------------

	| ds |
	
	ds := ToFTTreeDataSource roots: (ProtoObject allSubclasses sort: [ :a :b | a asString < b asString ]) children: [ :item | item subclasses sort: [ :a :b | a asString < b asString ] ].
	
	ds maxDepth: 4;
	searchStrategy: #allItems.
	
	ToFTTableMorph new
		extent: 200 @ 400;
		dataSource: ds;
		explicitFunction;
		openInWindow
	
	
Internal Representation and Key Implementation Points.
-------------------------------------------------

    Instance Variables
	childrenBlock:		I am a block use to generate the children of the Items. I can have 3 arguments: the current Item,   the collection of roots items and the depth of the item.
	items:		I am a collection of ToFTTreeItem that old the items of the first level of the tree.
	maxDepth:		I am an Integer that represent the max depth to dispaly.  If I am nil I display everything
	searchStrategy: 	 	I am a symbole to know what kind of search/filter strategy I need to apply.
			
    Class Variables
	SearchStrategies 		I am a Dictionary that map a Symbole (see searchStrategy) with a class that can search through a dataSource.  

"
Class {
	#name : #ToFTTreeDataSource,
	#superclass : #ToFTDataSource,
	#instVars : [
		'childrenBlock',
		'rootItem',
		'maxDepth',
		'searchStrategy',
		'unsortedElements'
	],
	#classVars : [
		'SearchStrategies'
	],
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #accessing }
ToFTTreeDataSource class >> defaultSearchStrategies [
	^ Dictionary new
		at: #rootsOnly put: ToFTRootItemsStrategy;
		at: #default put: ToFTVisibleItemsStrategy;
		at: #allItems put: ToFTAllItemsStrategy;
		yourself
]

{ #category : #'utilities - morph creation' }
ToFTTreeDataSource class >> emptyMorph [
	| icon |
	icon := (Smalltalk ui icons iconNamed: #empty) asMorph.
	icon form: (icon form scaledToSize: 16 @ 16).
	^ icon
]

{ #category : #'class initialization' }
ToFTTreeDataSource class >> initialize [

	SearchStrategies := nil
]

{ #category : #'instance creation' }
ToFTTreeDataSource class >> root: aRootItem children: aBlock [
	^ self new
		rootItem: aRootItem;
		childrenBlock: aBlock;
		addSourceToRootItem;
		yourself
]

{ #category : #accessing }
ToFTTreeDataSource class >> rootItemFor: aCollection [
	^ ToFTRootItem new
		data: aCollection;
		yourself
]

{ #category : #'instance creation' }
ToFTTreeDataSource class >> roots: aCollection children: aBlock [
	^ self root: (self rootItemFor: aCollection) children: aBlock
]

{ #category : #accessing }
ToFTTreeDataSource class >> searchStrategies [
	^ SearchStrategies ifNil: [ SearchStrategies := self defaultSearchStrategies ]
]

{ #category : #accessing }
ToFTTreeDataSource class >> searchStrategies: anObject [
	SearchStrategies := anObject
]

{ #category : #updating }
ToFTTreeDataSource >> addSourceToRootItem [
	rootItem dataSource: self
]

{ #category : #accessing }
ToFTTreeDataSource >> allShownItems [

	^ rootItem children flatCollect: [ :e | e withExpandedChildren ]
]

{ #category : #accessing }
ToFTTreeDataSource >> buttonFor: item [
	^ ( (self canDisplayChildrenOf: item) and: [item children isNotEmpty])
		ifTrue: [ item generateButton ]
		ifFalse: [ self class emptyMorph ]
]

{ #category : #testing }
ToFTTreeDataSource >> canDisplayChildrenOf: item [
	^ self maxDepth ifNil: [ true ] ifNotNil: [ self maxDepth > item depth ]
]

{ #category : #accessing }
ToFTTreeDataSource >> cellColumn: column row: rowIndex [
	| item cell |
	item := self dataAt: rowIndex.
	cell := ToFTIndentedCellElement new.
	cell indentBy: item depth * 16.

	cell addMorphBack: (self buttonFor: item).
	cell addMorphBack: (self toString: item data) asMorph.
	^ cell
]

{ #category : #accessing }
ToFTTreeDataSource >> childrenBlock [
	^ childrenBlock
]

{ #category : #accessing }
ToFTTreeDataSource >> childrenBlock: aBlockClosure [
	childrenBlock := aBlockClosure
]

{ #category : #'expanding-collapsing' }
ToFTTreeDataSource >> collapseAll [
	rootItem collapseAll.
	self tableRefresh
]

{ #category : #accessing }
ToFTTreeDataSource >> dataAt: index [
	^ rootItem childAt: index
]

{ #category : #'expanding-collapsing' }
ToFTTreeDataSource >> expandAll [
	rootItem expandAll.
	self tableRefresh
]

{ #category : #'expanding-collapsing' }
ToFTTreeDataSource >> expandAllTo: aDepth [
	self rootItem expandAllTo: aDepth
]

{ #category : #'expanding-collapsing' }
ToFTTreeDataSource >> expandRoots [
	self rootsItems do: #expand.
	self tableRefresh
]

{ #category : #accessing }
ToFTTreeDataSource >> headerColumn: column [
	^ self basicHeaderCellFor: column
]

{ #category : #updating }
ToFTTreeDataSource >> indexOfChangedItem [
	"I should be call when the user of the Fast Tree collapse or extand an Item. I return the index of the changed item. I should not be used by an other method than #updateSelectionWithCollectBlock:."

	1 to: self numberOfRows do: [ :index |
		(self dataAt: index) recentlyChanged
			ifTrue: [ ^ index ] ].

	^ self errorSubscriptBounds: self numberOfRows + 1
]

{ #category : #accessing }
ToFTTreeDataSource >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
ToFTTreeDataSource >> maxDepth: anObject [
	maxDepth := anObject
]

{ #category : #accessing }
ToFTTreeDataSource >> menuColumn: column row: rowIndex [
	rowIndex = 0
		ifTrue: [ ^ nil ].	"I could answer a menu without selection, but in this case I will just answer nil, which means 'no menu'"

	^ (UIManager default newMenuIn: self table for: self)
		add: 'Expand All ' target: self selector: #expandAll;
		add: 'Collapse All' target: self selector: #collapseAll;
		yourself
]

{ #category : #accessing }
ToFTTreeDataSource >> newDataSourceMatching: aToFTFilter [
	"I delegate the filter to a ToFTTreeFunctionStrategy."

	^ (self class searchStrategies at: self searchStrategy ifAbsent: [ self class searchStrategies at: #default ]) filterWith: aToFTFilter pattern dataSource: self
]

{ #category : #accessing }
ToFTTreeDataSource >> numberOfRows [
	^ self rootItem numberOfVisibleChildren
]

{ #category : #'expanding-collapsing' }
ToFTTreeDataSource >> preservingScrollbarPositionDo: aBlock [

	| oldScroll oldItems newScroll newItems |
	oldItems := self allShownItems size.
	oldScroll := self table verticalScrollBar value asFraction.

	aBlock value.

	newItems := self allShownItems size.
	newScroll := oldScroll = 0
		             ifTrue: [ 0 ]
		             ifFalse: [
			             oldScroll = 1
				             ifTrue: [ oldItems / newItems ]
				             ifFalse: [
					             oldScroll numerator
					             * (oldItems / oldScroll denominator)
					             / newItems ] ].

	self table verticalScrollBar setValue: newScroll
]

{ #category : #accessing }
ToFTTreeDataSource >> realElementAt: anIndex [
	^ (super realElementAt: anIndex) data
]

{ #category : #accessing }
ToFTTreeDataSource >> rootItem [
	^ rootItem
]

{ #category : #accessing }
ToFTTreeDataSource >> rootItem: anObject [
	rootItem := anObject
]

{ #category : #accessing }
ToFTTreeDataSource >> rootsItems [
	^ rootItem children
]

{ #category : #accessing }
ToFTTreeDataSource >> searchStrategy [
	^ searchStrategy ifNil: [ #default ]
]

{ #category : #accessing }
ToFTTreeDataSource >> searchStrategy: anObject [
	"Can be #default, #rootsOnly or #allItems. Use #allItems ONLY if the tree have not an infinit number of children, else you will get an infinit loop."

	searchStrategy := anObject
]

{ #category : #accessing }
ToFTTreeDataSource >> searchText: aString [
	"I delegate the search to a ToFTTreeFunctionStrategy."

	^ (self class searchStrategies at: self searchStrategy ifAbsent: [ self class searchStrategies at: #default ]) searchWith: aString dataSource: self
]

{ #category : #sorting }
ToFTTreeDataSource >> sortElements: aSortFunction [
	unsortedElements ifNil: [ unsortedElements := self rootsItems ].
	self rootItem children: (self rootItem children sorted: aSortFunction)
]

{ #category : #sorting }
ToFTTreeDataSource >> unsortElements [
	self rootItem children: unsortedElements.
	unsortedElements := nil
]

{ #category : #updating }
ToFTTreeDataSource >> updateData [
	"I am here to reset the items in case someone updated them."

	self rootItem updateData.
	self tableRefresh
]

{ #category : #updating }
ToFTTreeDataSource >> updateSelectionWithCollectBlock: aBlock [
	"I take a block with two parameters, the index of a selected element and
	the index of the item that collapsed/expanded. This block needs to return
	the index of the new selected element. I do not ensure that any of the
	newly selected elements are visible. Use #ensureVisibleFirstSelection for that."

	| index |
	self table selectedIndexes ifEmpty: [ ^ self ].

	index := self indexOfChangedItem.
	self table
		selectIndexes: ((self table selectedIndexes collect: [ :ind |
			aBlock value: ind value: index ]) asSet) asArray
		andMakeVisibleIf: false
]
