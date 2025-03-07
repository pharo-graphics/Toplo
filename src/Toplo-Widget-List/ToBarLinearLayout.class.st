Class {
	#name : #ToBarLinearLayout,
	#superclass : #BlLinearLayout,
	#traits : 'TToBarLayout',
	#classTraits : 'TToBarLayout classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarLinearLayout >> newHorizontalMeasurer [ 

	^ ToBarLinearLayoutHorizontalMeasurer new 
]

{ #category : #measure }
ToBarLinearLayout >> newVerticalMeasurer [ 

	^ ToBarLinearLayoutVerticalMeasurer new 
]
