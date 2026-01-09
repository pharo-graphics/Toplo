Class {
	#name : #ToFiniteListLinearLayout,
	#superclass : #BlLinearLayout,
	#traits : 'TToFiniteListLayout',
	#classTraits : 'TToFiniteListLayout classTrait',
	#instVars : [
		'maxMeasuredNodeSize'
	],
	#category : #'Toplo-Widget-List-NotUsed-InnerList-Finite-Layout'
}

{ #category : #accessing }
ToFiniteListLinearLayout >> maxMeasuredNodeSize [

	^ maxMeasuredNodeSize ifNil: [ maxMeasuredNodeSize := 0@0 ]
]

{ #category : #accessing }
ToFiniteListLinearLayout >> maxMeasuredNodeSize: aSize [

	maxMeasuredNodeSize := aSize
]

{ #category : #measure }
ToFiniteListLinearLayout >> newHorizontalMeasurer [ 

	^ ToFiniteListLinearLayoutHorizontalMeasurer new 
]

{ #category : #measure }
ToFiniteListLinearLayout >> newVerticalMeasurer [ 

	^ ToFiniteListLinearLayoutVerticalMeasurer new 
]
