Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#traits : 'TToBarMeasurer',
	#classTraits : 'TToBarMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
ToBarFlowLayoutMeasurer >> barNodes [

	^ children
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> fillChildrenFor: anElement with: anExtentSpec [

	super fillChildrenFor: anElement with: anExtentSpec.
	self shouldCheckUniformSize ifFalse: [ ^ self ].

	self barUniformMeasure.

	self barNodes do: [ :child |
		| element |
		element := child element.
		element isFake ifFalse: [
			child width: element measuredWidth.
			child height: element measuredHeight ] ]
]
