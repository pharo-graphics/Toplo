Class {
	#name : #ToFiniteListFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#traits : 'TToFiniteListMeasurer',
	#classTraits : 'TToFiniteListMeasurer classTrait',
	#instVars : [
		'maxMeasuredNodeSize'
	],
	#category : #'Toplo-Widget-List-NotUsed-InnerList-Finite-Layout'
}

{ #category : #'t - finite list measurer' }
ToFiniteListFlowLayoutMeasurer >> barNodes [

	^ children
]

{ #category : #measure }
ToFiniteListFlowLayoutMeasurer >> fillChildrenFor: anElement with: anExtentSpec [

	super fillChildrenFor: anElement with: anExtentSpec.
	self maxSizeDo: [ :maxSize | maxMeasuredNodeSize := maxSize ].
	self shouldCheckUniformSize ifFalse: [ ^ self ].

	self barUniformMeasure.

	self barNodes do: [ :child |
			| element |
			element := child element.
			child width: element measuredWidth.
			child height: element measuredHeight ]
]

{ #category : #accessing }
ToFiniteListFlowLayoutMeasurer >> maxMeasuredNodeSize [

	^ maxMeasuredNodeSize ifNil: [ maxMeasuredNodeSize := 0@0 ]
]
