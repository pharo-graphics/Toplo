Class {
	#name : 'ToListInfiniteElement',
	#superclass : 'ToInfiniteElement',
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'initialization' }
ToListInfiniteElement >> defaultDataSource [

	^ ToListObservableCollectionDataSource new
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultEventHandler [ 

	^ ToListInfiniteElementEventHandler new
]

{ #category : 'initialization' }
ToListInfiniteElement >> defaultListNodeFactory [

	^ [ :node :holder | node addChild: ((ToLabel text: holder data asString) hMatchParent) ]
]

{ #category : 'initialization' }
ToListInfiniteElement >> holderClass [

	^ ToNodeHolder 
]

{ #category : 'initialization' }
ToListInfiniteElement >> initialize [

	super initialize.
	self addEventHandler: self defaultEventHandler
]

{ #category : 'skin' }
ToListInfiniteElement >> newRawSkin [

	^ ToListInfiniteElementSkin new
]
