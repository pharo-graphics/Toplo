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
ToBarLinearLayoutVerticalMeasurer >> canMeasureExactUsingExcessSpaceForNode: aNode [

	^ (super canMeasureExactUsingExcessSpaceForNode: aNode) and: [
		  self shouldCheckUniformSize not ]
]

{ #category : #'private - measurement' }
ToBarLinearLayoutVerticalMeasurer >> childBreadthSpecForNode: aNode [

	| spec |
	spec := super childBreadthSpecForNode: aNode.
	self layout uniformNodeWidth ifTrue: [
		spec beExact: self layout maxMeasuredNodeSize x ].
	^ spec
]

{ #category : #measurement }
ToBarLinearLayoutVerticalMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all children to have the minimum size of the largest child"

	super largestMeasure.
	self layout uniformNodeHeight ifFalse: [ ^ self ].
	totalLength := 0.
	self barNodes do: [ :aNode |
		self updateTotalLengthFromLargestChild: aNode ]
]

{ #category : #measurement }
ToBarLinearLayoutVerticalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self maxSizeDo: [ :maxSize | self layout maxMeasuredNodeSize: maxSize ].
	self layout uniformNodeWidth ifFalse: [ ^ self ].
	self barUniformMeasure
]
