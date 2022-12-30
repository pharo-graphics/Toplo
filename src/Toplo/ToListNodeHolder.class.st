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

{ #category : #initialization }
ToListNodeHolder >> initialize [ 

	super initialize.
	dataToElementFactory := [ :d | ToLabeledNode new labelText: d asRopedText ]
]

{ #category : #accessing }
ToListNodeHolder >> nodeFactory [ 

	^ self dataToElementFactory 
]

{ #category : #accessing }
ToListNodeHolder >> nodeFactory: aValuable [

	self dataToElementFactory: aValuable
]
