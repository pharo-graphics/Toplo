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
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> collapseAll [

	| rootWrappers |
	rootWrappers := self dataSource select: [ :each | each nodeDepth = 0 ].
	rootWrappers reverseDo: [ :w | w collapse ]
]

{ #category : #initialization }
ToAbstractTreeElement >> defaultDataAccessor [

	^ ToTreeDataAccessor new 
]

{ #category : #initialization }
ToAbstractTreeElement >> defaultDataSource [

	^ ToTreeDataSource new
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> expandAll [

	| rootWrappers |
	rootWrappers := self dataSource select: [ :each | each isRoot ].
	rootWrappers do: [ :w | w expandAll ]
]

{ #category : #'expanding-collapsing' }
ToAbstractTreeElement >> expandRoots [

	self dataSource roots do: [ :each | each expand ]
]

{ #category : #initialization }
ToAbstractTreeElement >> initializeDataAccessor [

	dataAccessor := self defaultDataAccessor listElement: self
]

{ #category : #initialization }
ToAbstractTreeElement >> initializeDataSource [

	super initializeDataSource.
	dataSource
		addEventHandlerOn: ToAbstractCollectionChangedEvent
		do: [ :event | self dataAccessor dispatchEvent: event copy ]
]

{ #category : #'instance creation' }
ToAbstractTreeElement >> sieveClass [

	^ ToWrappedListElementSieve
]
