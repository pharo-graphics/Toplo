Class {
	#name : #ToFiniteListFlowLayout,
	#superclass : #BlFlowLayout,
	#traits : 'TToFiniteListLayout',
	#classTraits : 'TToFiniteListLayout classTrait',
	#category : #'Toplo-Widget-List-NotUsed-InnerList-Finite-Layout'
}

{ #category : #accessing }
ToFiniteListFlowLayout >> maxMeasuredNodeSize [

	^ measurer maxMeasuredNodeSize
]

{ #category : #initialization }
ToFiniteListFlowLayout >> newMeasurer [ 

	^ ToFiniteListFlowLayoutMeasurer for: self
]
