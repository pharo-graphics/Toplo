Class {
	#name : #ToBarLinearLayoutHorizontalMeasurer,
	#superclass : #BlLinearLayoutHorizontalMeasurer,
	#traits : 'TToBarMeasurer',
	#classTraits : 'TToBarMeasurer classTrait',
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
ToBarLinearLayoutHorizontalMeasurer >> barNodes [

	^ nodes
]

{ #category : #measurement }
ToBarLinearLayoutHorizontalMeasurer >> canMeasureExactUsingExcessSpaceForNode: aNode [

	^ (super canMeasureExactUsingExcessSpaceForNode: aNode) and: [self shouldCheckUniformSize not]
]

{ #category : #'private - measurement' }
ToBarLinearLayoutHorizontalMeasurer >> childBreadthSpecForNode: aNode [

	| spec |
	spec := super childBreadthSpecForNode: aNode.
	self layout uniformNodeHeight ifTrue: [
		spec beExact: self layout maxMeasuredNodeSize y ].
	^ spec
]

{ #category : #measurement }
ToBarLinearLayoutHorizontalMeasurer >> largestMeasure [
	"I re-measure my length for the case when we consider all children to have the minimum size of the largest child"

	super largestMeasure.
	self layout uniformNodeWidth ifFalse: [ ^ self ].
	totalLength := 0.
	self barNodes do: [ :aNode |
		aNode element isFake ifFalse: [ 
			aNode element isHMatchParent ifFalse: [self updateTotalLengthFromLargestChild: aNode ] ] ]
]

{ #category : #measurement }
ToBarLinearLayoutHorizontalMeasurer >> preMeasure [
	"See how wide/tall everyone is. Also remember max breadth."

	super preMeasure.
	self maxSizeDo: [ :maxSize | self layout maxMeasuredNodeSize: maxSize ].
	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self barUniformMeasure
]
