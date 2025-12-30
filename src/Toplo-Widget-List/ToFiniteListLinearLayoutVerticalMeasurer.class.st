Class {
	#name : #ToFiniteListLinearLayoutVerticalMeasurer,
	#superclass : #BlLinearLayoutVerticalMeasurer,
	#traits : 'TToFiniteListMeasurer',
	#classTraits : 'TToFiniteListMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'t - finite list measurer' }
ToFiniteListLinearLayoutVerticalMeasurer >> barNodes [

	^ nodes
]

{ #category : #measurement }
ToFiniteListLinearLayoutVerticalMeasurer >> canMeasureExactUsingExcessSpaceForNode: aNode [

	^ (super canMeasureExactUsingExcessSpaceForNode: aNode) and: [
		  self shouldCheckUniformSize not ]
]

{ #category : #'private - measurement' }
ToFiniteListLinearLayoutVerticalMeasurer >> childBreadthSpecForNode: aNode [

	| spec |
	spec := super childBreadthSpecForNode: aNode.
	self layout uniformNodeWidth ifTrue: [
		spec beExact: self layout maxMeasuredNodeSize x ].
	^ spec
]

{ #category : #measurement }
ToFiniteListLinearLayoutVerticalMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all children to have the minimum size of the largest child"

	super largestMeasure.
	self layout uniformNodeHeight ifFalse: [ ^ self ].
	totalLength := 0.
	self barNodes do: [ :aNode |
		self updateTotalLengthFromLargestChild: aNode ]
]

{ #category : #measurement }
ToFiniteListLinearLayoutVerticalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self maxSizeDo: [ :maxSize | self layout maxMeasuredNodeSize: maxSize ].
	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self barUniformMeasure
]
