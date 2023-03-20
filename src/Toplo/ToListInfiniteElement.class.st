Class {
	#name : #ToListInfiniteElement,
	#superclass : #ToInfiniteElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListInfiniteElement >> defaultDataSource [

	^ ToObservableCollectionDataSource new
]

{ #category : #'t - initialization dresser' }
ToListInfiniteElement >> defaultDresser [ 

	^ ToListInfiniteElementDresser new
]

{ #category : #initialization }
ToListInfiniteElement >> defaultListNodeFactory [

	^ ToActionDataToElementConverter new valuable: [ :d :h | ToLabeledNode new labelText: d ]
]

{ #category : #initialization }
ToListInfiniteElement >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #initialization }
ToListInfiniteElement >> initialize [

	super initialize
]

{ #category : #'hooks - children' }
ToListInfiniteElement >> onChildAttached: anElement [
	"Sent when an item element is attached to this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications of child elements
	as they become attached. This will be called before an InfiniteLayout measures or lays out
	the element and is a good time to perform these changes"
	super onChildAttached: anElement.
	

]

{ #category : #'hooks - children' }
ToListInfiniteElement >> onChildDetached: anElement [
	"I sent when an item element is detached from this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications
	of child elements as they become detached. This will be sent as an
	InfiniteLayout fully detaches the child element from the parent"
	super onChildDetached: anElement
]
