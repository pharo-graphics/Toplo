Class {
	#name : #ToFiniteListLinearLayoutHorizontalMeasurer,
	#superclass : #BlLinearLayoutHorizontalMeasurer,
	#traits : 'TToFiniteListMeasurer',
	#classTraits : 'TToFiniteListMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'t - bar measurer' }
ToFiniteListLinearLayoutHorizontalMeasurer >> barNodes [

	^ nodes
]

{ #category : #measurement }
ToFiniteListLinearLayoutHorizontalMeasurer >> canMeasureExactUsingExcessSpaceForNode: aNode [

	^ (super canMeasureExactUsingExcessSpaceForNode: aNode) and: [self shouldCheckUniformSize not]
]

{ #category : #'private - measurement' }
ToFiniteListLinearLayoutHorizontalMeasurer >> childBreadthSpecForNode: aNode [

	| spec |
	spec := super childBreadthSpecForNode: aNode.
	self layout uniformNodeHeight ifTrue: [
		spec beExact: self layout maxMeasuredNodeSize y ].
	^ spec
]

{ #category : #measurement }
ToFiniteListLinearLayoutHorizontalMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all children to have the minimum size of the largest child"

	super largestMeasure.
	self layout uniformNodeWidth ifFalse: [ ^ self ].
	totalLength := 0.
	self barNodes do: [ :aNode |
			aNode element isHMatchParent ifFalse: [
				self updateTotalLengthFromLargestChild: aNode ] ]
]

{ #category : #measurement }
ToFiniteListLinearLayoutHorizontalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self maxSizeDo: [ :maxSize | self layout maxMeasuredNodeSize: maxSize ].
	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self barUniformMeasure
]
