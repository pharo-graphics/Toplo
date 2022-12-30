Class {
	#name : #ToList,
	#superclass : #ToInfinite,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToList >> defaultDataSourceClass [

	^ ToListDataSource 
]

{ #category : #initialization }
ToList >> defaultHolderFactory [

	^ ToListActionHolderFactory new.
]

{ #category : #initialization }
ToList >> nodeFactory: aValuable [

	self holderFactory:
		(ToListActionHolderFactory new action: [ :infinite | 
			 ToListNodeHolder new nodeFactory: aValuable ])
]
