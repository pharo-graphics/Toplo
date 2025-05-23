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
	rootWrappers := self dataSource select: [ :each | each isRoot ].
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

{ #category : #initialization }
ToAbstractTreeElement >> initializeDataSource [

	super initializeDataSource.
	dataSource
		addEventHandlerOn: ToCollectionChangedEvent
		do: [ :event | self dataAccessor dispatchEvent: event copy ]
]
