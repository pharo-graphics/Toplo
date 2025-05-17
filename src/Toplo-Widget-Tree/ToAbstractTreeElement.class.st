"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes.

My model relies on a DataSource holding the data displayed and a TreeNodeManager dealing with the TreeNodes
"
Class {
	#name : #ToAbstractTreeElement,
	#superclass : #ToListElement,
	#instVars : [
		'dataSourceWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #examples }
ToAbstractTreeElement class >> exampleExpandAllAndCollapseAll [

	| tree expandAllButton collapseAllButton container |
	tree := self new.
	tree dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper.
	tree dataAccessor addAll: (1 to: 100).

	expandAllButton := ToButton new
		                   label: (ToLabel text: 'Expand All');
		                   newClickAction: [ tree expandAll ];
		                   yourself.
	collapseAllButton := ToButton new
		                     label: (ToLabel text: 'Collapse All');
		                     newClickAction: [ tree collapseAll ];
		                     yourself.

	container := ToElement new
		             layout: BlLinearLayout vertical;
		             hMatchParent;
		             vMatchParent.
	container addChildren: {
			expandAllButton.
			collapseAllButton.
			tree }.
	container openInSpace
]

{ #category : #examples }
ToAbstractTreeElement class >> exampleMixingSubclassesAndMethods [
	"For this example we created a new wrapper dealing with classes and methods at the same time, a new Node was also created (ToTreeSubAndMethNode) to apply a new skin (ToTreeNodeSubAndMethSkin) with new icons and a different background color for methods "
	

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemSubclassesAndMethodsWrapper.
	l nodeManager nodeFactory: [ :holder | ToTreeSubAndMethNode new ].
	l dataAccessor add: BlElement.
	l dataAccessor add: Collection.
	l dataAccessor add: String.

	l openInSpace
]

{ #category : #examples }
ToAbstractTreeElement class >> examplePreviousIntegers [

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper.
	l dataAccessor addAll: (1 to: 10).


	l openInSpace
]

{ #category : #examples }
ToAbstractTreeElement class >> exampleProtoObjectSubclasses [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemClassWrapper.
	l dataAccessor add: ProtoObject.

	l openInSpace
]

{ #category : #examples }
ToAbstractTreeElement class >> exampleStringWithoutFirstLetter [

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemStringWithoutFirstLetterWrapper.
	l dataAccessor add: 'BlElement'.
	l dataAccessor add: 'Collection'.
	l dataAccessor add: 'String'.

	l openInSpace
]

{ #category : #examples }
ToAbstractTreeElement class >> exampleWithFewClasses [
	"This example allows us to expand and collapse classes to see their subclasses, however the collapsing is not done recursively on the children, causing issues if we expand classes to at least depth 3 and collapse depth 1"

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemClassWrapper.
	l dataAccessor add: BlElement.
	l dataAccessor add: Collection.
	l dataAccessor add: String.

	l openInSpace
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> collapseAll [ 

	self dataAccessor collapseAll
]

{ #category : #accessing }
ToAbstractTreeElement >> dataAccessor [ 

	^ dataSourceWrapper
]

{ #category : #accessing }
ToAbstractTreeElement >> dataWrapperClass [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractTreeElement >> defaultNodeManagerClass [

	^ ToGenericTreeNodeManager  
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> expandAll [ 

	self dataAccessor expandAll
]

{ #category : #initialization }
ToAbstractTreeElement >> initialize [ 

	super initialize.
	self initializeDataSourceWrapper.
]

{ #category : #initialization }
ToAbstractTreeElement >> initializeDataSourceWrapper [

	dataSourceWrapper := ToTreeDataSourceWrapper new treeElement: self
]
