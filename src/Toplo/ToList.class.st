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
	dataToElementFactory := [ :d | ToLabeledNode new labelText: d  ].

]

{ #category : #accessing }
ToList >> nodeFactory [

	^ self dataToElementFactory 
]

{ #category : #accessing }
ToList >> nodeFactory: aValuable [

	self dataToElementFactory: aValuable
]
