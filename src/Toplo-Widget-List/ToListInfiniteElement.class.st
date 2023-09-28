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
ToListInfiniteElement >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListInfiniteElement >> defaultPadding [

	^ BlInsets all: 4
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
ToListInfiniteElement >> initialize [ 

	super initialize.
	self outskirts: BlOutskirts outside.
	self padding: self defaultPadding.
	self margin: self defaultMargin.
	self clipChildren: true.
	self  border: (BlBorder
			 paint: self theme editor borderColor
			 width: 1).
	self background: Color transparent
]

{ #category : #initialization }
ToListInfiniteElement >> nodeClass [

	^ ToLabeledNode
]
