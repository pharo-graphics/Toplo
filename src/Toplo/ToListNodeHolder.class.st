Class {
	#name : #ToListNodeHolder,
	#superclass : #ToInfiniteElementHolder,
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToListNodeHolder >> data: aData [

	super data: aData.
	itemElement holder: self
	
]
