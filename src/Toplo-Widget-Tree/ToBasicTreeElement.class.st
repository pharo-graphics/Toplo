"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes.

My model relies on a DataSource holding the data displayed and a TreeNodeManager dealing with the TreeNodes
"
Class {
	#name : #ToBasicTreeElement,
	#superclass : #ToBasicWrappedListElement,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'expanding-collapsing' }
ToBasicTreeElement >> collapseAll [

	| rootWrappers |
	rootWrappers := self dataSource select: [ :each | each nodeDepth = 0 ].
	rootWrappers reverseDo: [ :w | w collapse ]
]

{ #category : #initialization }
ToBasicTreeElement >> defaultDataAccessor [

	^ ToTreeDataAccessor new 
]

{ #category : #initialization }
ToBasicTreeElement >> defaultDataSource [

	^ ToTreeDataSource new
]

{ #category : #initialization }
ToBasicTreeElement >> defaultNodeManagerClass [ 

	^ ToTreeNodeManager
]

{ #category : #'expanding-collapsing' }
ToBasicTreeElement >> expandAll [

	| rootWrappers |
	rootWrappers := self dataSource select: [ :each | each isRoot ].
	rootWrappers do: [ :w | w expandAll ]
]

{ #category : #'expanding-collapsing' }
ToBasicTreeElement >> expandRoots [

	self dataSource roots do: [ :each | each expand ]
]

{ #category : #configuration }
ToBasicTreeElement >> newToConfiguration [ 

	^ ToTreeConfiguration new
]
