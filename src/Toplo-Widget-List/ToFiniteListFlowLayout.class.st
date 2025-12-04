Class {
	#name : #ToFiniteListFlowLayout,
	#superclass : #BlFlowLayout,
	#traits : 'TToFiniteListLayout',
	#classTraits : 'TToFiniteListLayout classTrait',
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #accessing }
ToFiniteListFlowLayout >> maxMeasuredNodeSize [

	^ measurer maxMeasuredNodeSize
]

{ #category : #initialization }
ToFiniteListFlowLayout >> newMeasurer [ 

	^ ToFiniteListFlowLayoutMeasurer for: self
]
