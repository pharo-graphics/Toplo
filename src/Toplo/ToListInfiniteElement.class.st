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

	^ ToActionDataToElementConverter new valuable: [ :d :h | self nodeClass new labelText: d; hMatchParent; yourself ]
]

{ #category : #initialization }
ToListInfiniteElement >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #'t - infinite accessing' }
ToListInfiniteElement >> infinite [ 

	^ self
]

{ #category : #initialization }
ToListInfiniteElement >> nodeClass [

	^ ToLabeledNode
]

{ #category : #initialization }
ToListInfiniteElement >> requestFocus [

	^ super requestFocus 
]
