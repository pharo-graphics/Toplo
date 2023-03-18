Class {
	#name : #ToListElement,
	#superclass : #ToInfiniteElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListElement >> defaultDataSource [

	^ ToObservableCollectionDataSource new
]

{ #category : #'t - initialization dresser' }
ToListElement >> defaultDresser [ 

	^ ToListDresser new
]

{ #category : #initialization }
ToListElement >> defaultListNodeFactory [

	^ ToActionDataToElementConverter new valuable: [ :d :h | ToLabeledNode new labelText: d ]
]

{ #category : #initialization }
ToListElement >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #initialization }
ToListElement >> initialize [

	super initialize
]

{ #category : #'hooks - children' }
ToListElement >> onChildAttached: anElement [
	"Sent when an item element is attached to this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications of child elements
	as they become attached. This will be called before an InfiniteLayout measures or lays out
	the element and is a good time to perform these changes"
	super onChildAttached: anElement.
	

]

{ #category : #'hooks - children' }
ToListElement >> onChildDetached: anElement [
	"I sent when an item element is detached from this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications
	of child elements as they become detached. This will be sent as an
	InfiniteLayout fully detaches the child element from the parent"
	super onChildDetached: anElement
]
