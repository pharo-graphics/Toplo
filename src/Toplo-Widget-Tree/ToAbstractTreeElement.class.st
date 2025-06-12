"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes.

My model relies on a DataSource holding the data displayed and a TreeNodeManager dealing with the TreeNodes
"
Class {
	#name : #ToAbstractTreeElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
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
ToAbstractTreeElement >> defaultDataSource [

	^ ToTreeDataSource new
]

{ #category : #initialization }
ToAbstractTreeElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> expandAll [

	self dataSource rootsDo: [ :each | each isRoot ]
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> expandRoots [

	self dataSource rootsDo: [ :w | w expand ]
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
		addEventHandlerOn: ToAbstractCollectionChangedEvent
		do: [ :event | self dataAccessor dispatchEvent: event copy ]
]

{ #category : #'instance creation' }
ToAbstractTreeElement >> newSieve [

	^ ToTreeElementSieve new
]
