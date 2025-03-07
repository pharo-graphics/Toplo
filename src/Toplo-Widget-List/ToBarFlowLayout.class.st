Class {
	#name : #ToBarFlowLayout,
	#superclass : #BlFlowLayout,
	#traits : 'TToBarLayout',
	#classTraits : 'TToBarLayout classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #initialization }
ToBarFlowLayout >> newMeasurer [ 

	^ ToBarFlowLayoutMeasurer for: self
]
