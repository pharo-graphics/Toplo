Class {
	#name : #ToBarLinearLayoutVerticalMeasurer,
	#superclass : #BlLinearLayoutVerticalMeasurer,
	#traits : 'TToBarMeasurer',
	#classTraits : 'TToBarMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
ToBarLinearLayoutVerticalMeasurer >> barNodes [

	^ nodes
]

{ #category : #measurement }
ToBarLinearLayoutVerticalMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all children to have the minimum size of the largest child"

	super largestMeasure.
	self layout hasUniformNodeHeight ifFalse: [ ^ self ].
	totalLength := 0.
	self barNodes do: [ :aNode |
		aNode element isFake ifFalse: [ self updateTotalLengthFromLargestChild: aNode ] ]
]

{ #category : #measurement }
ToBarLinearLayoutVerticalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self barUniformMeasure
]
