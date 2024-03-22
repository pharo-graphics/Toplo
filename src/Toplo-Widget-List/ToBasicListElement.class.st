Class {
	#name : #ToBasicListElement,
	#superclass : #ToAbstractListElement,
	#instVars : [
		'nodeFactory',
		'nodeBuilder',
		'nodeReleaser',
		'nodeHolderBuilder',
		'nodeHolderReleaser'
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
ToBasicListElement >> defaultEventHandler [

	^ ToBasicListElementEventHandler new
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

{ #category : #initialization }
ToBasicListElement >> defaultNodeHolderBuilder [

	^ [ :holder :boundData | holder dataItem: boundData ]
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeHolderFactory [

	^ [ ToBasicNodeHolder new ]
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeHolderReleaser [

	^ [ :theHolder | theHolder dataItem: nil ]
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeReleaser [

	^ [ :node :holder | node removeChildren ]
]

{ #category : #initialization }
ToBasicListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents , {
		  ToObservableCollectionEvent.
		  BlInfiniteDataSourceEvent }
]

{ #category : #initialization }
ToBasicListElement >> initialize [

	super initialize.
	nodeFactory := self defaultNodeFactory.
	nodeHolderBuilder := self defaultNodeHolderBuilder.
	nodeHolderReleaser := self defaultNodeHolderReleaser.
	nodeBuilder := self defaultNodeBuilder.
	nodeReleaser := self defaultNodeReleaser 
]

{ #category : #'instance creation' }
ToBasicListElement >> newPrimarySelectionModel [

	^ self newSelectionModel 
]

{ #category : #'instance creation' }
ToBasicListElement >> newSelectionModel [

	^ ToListSelectionModel new
		  itemCountGetter: [ self dataSource itemCount ];
		  yourself
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
ToBasicListElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #accessing }
ToBasicListElement >> nodeHolderBuilder [

	"aValuable takes 2 args: the holder to build and second the dataItem that is bound to the holder "

	^ nodeHolderBuilder 
]

{ #category : #accessing }
ToBasicListElement >> nodeHolderBuilder: aBuilder [

	"aValuable takes 1 arg: the holder to build and second "

	nodeHolderBuilder := aBuilder
]

{ #category : #accessing }
ToBasicListElement >> nodeHolderReleaser [
	"aValuable takes 1 arg: the holder to release  "

	^ nodeHolderReleaser
]

{ #category : #accessing }
ToBasicListElement >> nodeHolderReleaser: aValuable [
	"aValuable takes 1 arg: the holder to release  "

	nodeHolderReleaser := aValuable
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
