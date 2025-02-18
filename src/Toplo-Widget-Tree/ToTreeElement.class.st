"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes.

My model relies on a DataSource holding the data displayed and a TreeNodeManager dealing with the TreeNodes
"
Class {
	#name : #ToTreeElement,
	#superclass : #ToListElement,
	#instVars : [
		'dataWrapperClass',
		'dataSourceWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleExpandAllAndCollapseAll [

	| tree expandAllButton collapseAllButton container |
	tree := self new.
	tree dataWrapperClass: ToTreeDataItemRandomIntegersWrapper.
	tree dataAccessor addAll: (1 to: 10).

	expandAllButton := ToButton new
		                   label: (ToLabel text: 'Expand All');
		                   whenClickedDo: [ :e | tree expandAll ].
	collapseAllButton := ToButton new
		                     label: (ToLabel text: 'Collapse All');
		                     whenClickedDo: [ :e | tree collapseAll ].

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

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleIntegerHalf [

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemRandomIntegersWrapper.
	l dataAccessor addAll: (1 to: 10).


	l openInSpace
]

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleProtoObjectSubclasses [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemClassWrapper.
	l dataAccessor add: ProtoObject.

	l openInSpace
]

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleWithFewClasses [
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
ToTreeElement >> collapseAll [ 

	self dataAccessor collapseAll
]

{ #category : #accessing }
ToTreeElement >> dataAccessor [ 

	^ dataSourceWrapper
]

{ #category : #accessing }
ToTreeElement >> dataWrapperClass [

	^ dataWrapperClass ifNil: [ self defaultDataWrapperClass ]
]

{ #category : #accessing }
ToTreeElement >> dataWrapperClass: aToTreeDataItemWrapperClass [

	dataWrapperClass := aToTreeDataItemWrapperClass.
"	dataSource dataWrapperClass: aToTreeDataItemWrapperClass."
	dataSourceWrapper dataWrapperClass: aToTreeDataItemWrapperClass.
]

{ #category : #initialization }
ToTreeElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToTreeElement >> defaultDataWrapperClass [

	^ ToTreeDataItemWrapper 
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [

	^ ToGenericTreeNodeManager  
]

{ #category : #'expanding-collapsing' }
ToTreeElement >> expandAll [ 

	self dataAccessor expandAll
]

{ #category : #initialization }
ToTreeElement >> initialize [ 

	super initialize.
	self initializeDataSourceWrapper.
]

{ #category : #initialization }
ToTreeElement >> initializeDataSource [

	super initializeDataSource.
	"dataSource dataWrapperClass: self dataWrapperClass"
]

{ #category : #initialization }
ToTreeElement >> initializeDataSourceWrapper [

	dataSourceWrapper := ToTreeDataSourceWrapper new dataSource: dataSource.
	dataSourceWrapper dataWrapperClass: self dataWrapperClass.
]
