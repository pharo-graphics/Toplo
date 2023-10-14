Class {
	#name : 'ToListInfiniteElement',
	#superclass : 'ToInfiniteElement',
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'initialization' }
ToListInfiniteElement >> defaultBackground [

	^ Color transparent
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultBlurBorder [

	^ BlBorder
			 paint: self defaultBorderColor
			 width: self defaultBorderWidth
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultBorderColor [ 

	^ self theme editor borderColor
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultBorderWidth [ 

	^ 1
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultDataSource [

	^ ToListObservableCollectionDataSource new
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultEventHandler [ 

	^ ToListInfiniteElementEventHandler new
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultFocusBorder [

	^ BlBorder
			 paint: self defaultFocusBorderColor
			 width: self defaultBorderWidth
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultFocusBorderColor [

	^ self theme editor focusedBorderColor
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultListNodeFactory [

	^ ToActionDataToElementConverter new valuable: [ :d :h | self nodeClass new labelText: d; hMatchParent; yourself ]
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultPadding [

	^ BlInsets all: 4
]

{ #category : 'initialization' }
ToListInfiniteElement >> holderClass [

	^ ToNodeHolder 
]

{ #category : 'initialization' }
ToListInfiniteElement >> initialize [

	super initialize.
	self outskirts: BlOutskirts outside.
	self padding: self defaultPadding.
	self margin: self defaultMargin.
	self clipChildren: true.
	self border: self defaultBorder.
	self background: self defaultBackground.
	self addEventHandler: self defaultEventHandler
]

{ #category : 'initialization' }
ToListInfiniteElement >> nodeClass [

	^ ToLabeledNode
]
