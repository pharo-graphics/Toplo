Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#traits : 'TToBarMeasurer',
	#classTraits : 'TToBarMeasurer classTrait',
	#instVars : [
		'maxMeasuredNodeSize'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
ToBarFlowLayoutMeasurer >> barNodes [

	^ children
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> fillChildrenFor: anElement with: anExtentSpec [

	super fillChildrenFor: anElement with: anExtentSpec.
	self maxSizeDo: [ :maxSize | maxMeasuredNodeSize := maxSize ].
	self shouldCheckUniformSize ifFalse: [ ^ self ].

	self barUniformMeasure.

	self barNodes do: [ :child |
		| element |
		element := child element.
		element isFake ifFalse: [
			child width: element measuredWidth.
			child height: element measuredHeight ] ]
]

{ #category : #accessing }
ToBarFlowLayoutMeasurer >> maxMeasuredNodeSize [

	^ maxMeasuredNodeSize ifNil: [ maxMeasuredNodeSize := 0@0 ]
]
