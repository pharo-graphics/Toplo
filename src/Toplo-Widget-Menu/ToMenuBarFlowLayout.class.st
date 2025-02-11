Class {
	#name : #ToMenuBarFlowLayout,
	#superclass : #ToBarFlowLayout,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #initialization }
ToMenuBarFlowLayout >> newMeasurer [ 

	^ ToMenuBarFlowLayoutMeasurer for: self
]
