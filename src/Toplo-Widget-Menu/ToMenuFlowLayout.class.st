Class {
	#name : #ToMenuFlowLayout,
	#superclass : #ToBarFlowLayout,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #initialization }
ToMenuFlowLayout >> newMeasurer [ 

	^ ToMenuFlowLayoutMeasurer for: self
]
