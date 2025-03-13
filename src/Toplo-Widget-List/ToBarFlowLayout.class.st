Class {
	#name : #ToBarFlowLayout,
	#superclass : #BlFlowLayout,
	#traits : 'TToBarLayout',
	#classTraits : 'TToBarLayout classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToBarFlowLayout >> maxMeasuredNodeSize [

	^ measurer maxMeasuredNodeSize
]

{ #category : #initialization }
ToBarFlowLayout >> newMeasurer [ 

	^ ToBarFlowLayoutMeasurer for: self
]
