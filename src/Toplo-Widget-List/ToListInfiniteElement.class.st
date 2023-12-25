Class {
	#name : #ToListInfiniteElement,
	#superclass : #ToInfiniteElement,
	#category : 'Toplo-Widget-List-Infinite'
}

{ #category : #initialization }
ToListInfiniteElement >> defaultDataSource [

	^ ToListObservableCollectionDataSource new
]

{ #category : #initialization }
ToListInfiniteElement >> defaultEventHandler [ 

	^ ToListInfiniteElementEventHandler new
]

{ #category : #initialization }
ToListInfiniteElement >> defaultNodeBuilder [

	^ [ :node :holder | node addChild: ((ToLabel text: holder data asString) hMatchParent) ]
]

{ #category : #initialization }
ToListInfiniteElement >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #initialization }
ToListInfiniteElement >> initialize [

	super initialize.
	self addEventHandler: self defaultEventHandler
]

{ #category : #skin }
ToListInfiniteElement >> newRawSkin [

	^ ToListInfiniteElementSkin new
]
