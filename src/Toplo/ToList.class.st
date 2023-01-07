Class {
	#name : #ToList,
	#superclass : #ToInfiniteElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToList >> defaultDataSource [

	^ ToObservableCollectionDataSource new
]

{ #category : #'t - initialization dresser' }
ToList >> defaultDresser [ 

	^ ToListDresser new
]

{ #category : #initialization }
ToList >> defaultNodeFactory [

	^ [ :d | ToLabeledNode new labelText: d ]
]

{ #category : #initialization }
ToList >> holderClass [

	^ ToListNodeHolder 
]
