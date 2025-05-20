"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes.

My model relies on a DataSource holding the data displayed and a TreeNodeManager dealing with the TreeNodes
"
Class {
	#name : #ToAbstractTreeElement,
	#superclass : #ToAbstractListElement,
	#instVars : [
		'dataAccessor'
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
ToAbstractTreeElement class >> examplePreviousIntegers [

	| l |
	l := self new.
	l dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper.
	l dataAccessor addAll: (1 to: 10).


	l openInSpace
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> collapseAll [

	| rootWrappers |
	rootWrappers := self dataSource select: [ :each | each nodeDepth = 0 ].
	rootWrappers reverseDo: [ :w | w collapse ]
]

{ #category : #accessing }
ToAbstractTreeElement >> dataAccessor [ 

	^ dataAccessor
]

{ #category : #initialization }
ToAbstractTreeElement >> defaultDataAccessor [

	^ ToTreeDataAccessor new 
]

{ #category : #initialization }
ToAbstractTreeElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> expandAll [

	| rootWrappers |
	rootWrappers := self dataSource select: [ :each | each nodeDepth = 0 ].
	rootWrappers do: [ :w | w expandAll ]
]

{ #category : #initialization }
ToAbstractTreeElement >> initialize [ 

	super initialize.
	self initializeDataAccessor.
]

{ #category : #initialization }
ToAbstractTreeElement >> initializeDataAccessor [

	dataAccessor := self defaultDataAccessor treeElement: self
]
