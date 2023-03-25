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

{ #category : #'t - infinite accessing' }
ToListInfiniteElement >> infinite [ 

	^ self
]
