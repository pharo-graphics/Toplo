Class {
	#name : #ToList,
	#superclass : #ToInfinite,
	#category : #'Toplo-Core-Infinite'
}

{ #category : #initialization }
ToList >> defaultDataSourceClass [

	^ ToListDataSource 
]

{ #category : #initialization }
ToList >> initialize [

	super initialize.
	holderFactory := [ ToListNodeHolder new ].

]
