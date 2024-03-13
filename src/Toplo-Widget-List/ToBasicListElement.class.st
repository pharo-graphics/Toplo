Class {
	#name : #ToBasicListElement,
	#superclass : #ToAbstractListElement,
	#instVars : [
		'nodeFactory',
		'nodeBuilder',
		'nodeReleaser'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #accessing }
ToBasicListElement >> dataAccessor [

	^ self dataSource
]

{ #category : #initialization }
ToBasicListElement >> defaultDataSource [

	^ ToObservableCollectionInfiniteDataSource new
]

{ #category : #initialization }
ToBasicListElement >> defaultInfiniteElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeBuilder [

	^ [ :node :holder |
	  node addChild: (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeFactory [

	^ [ :holder | ToNode new ]
]

{ #category : #accessing }
ToBasicListElement >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeReleaser [

	^ [ :node :holder | node removeChildren ]
]

{ #category : #initialization }
ToBasicListElement >> initialize [

	super initialize.
	nodeFactory := self defaultNodeFactory.
	nodeBuilder := self defaultNodeBuilder.
	nodeReleaser := self defaultNodeReleaser 
]

{ #category : #accessing }
ToBasicListElement >> nodeBuilder [

	"aValuable takes 2 args: first, the node to build and second, its holder in the list element "
	^ nodeBuilder
]

{ #category : #accessing }
ToBasicListElement >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the node to build and second, its holder in the list element "
	nodeBuilder := aValuable
]

{ #category : #accessing }
ToBasicListElement >> nodeFactory [
	" returns aValuable that takes a node holder as unique argument and which running results in a new node "

	^ nodeFactory
]

{ #category : #accessing }
ToBasicListElement >> nodeReleaser [
	"aValuable takes 2 args: first, the ToNode to release and second, its holder in the list element "

	^ nodeReleaser
]

{ #category : #accessing }
ToBasicListElement >> nodeReleaser: aValuable [
	"aValuable takes 2 args: first, the ToNode to release and second, its holder in the list element "

	nodeReleaser := aValuable
]
