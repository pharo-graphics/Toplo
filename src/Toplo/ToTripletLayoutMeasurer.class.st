Class {
	#name : #ToTripletLayoutMeasurer,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'parent',
		'breadthSpec',
		'lengthSpec',
		'orientation',
		'totalLength',
		'totalWeight',
		'extentSpec',
		'usedExcessSpace',
		'matchBreadth',
		'maxBreadth',
		'measuredLength',
		'layout'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #accessing }
ToTripletLayoutMeasurer >> breadthSpec [
	^ breadthSpec
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> canMeasureExactUsingExcessSpaceForNode: aNode [

	^ self isLengthExact and: [ self shouldUseExcessSpaceForNode: aNode ]
]

{ #category : #'private - measurement' }
ToTripletLayoutMeasurer >> childBreadthSpecForNode: aNode [

	^ parent layout
		  measurementSpecFor: breadthSpec
		  usedSize:
		  (orientation paddingBreadth: parent) + aNode marginBreadth
		  resizer: aNode breadthResizer
]

{ #category : #initialization }
ToTripletLayoutMeasurer >> initialize [
	super initialize.

	totalLength := 0.0.
	totalWeight := 0.0.
	usedExcessSpace := 0.0.
	matchBreadth := false.
	measuredLength := 0.0.
	maxBreadth := 0.0
]

{ #category : #initialization }
ToTripletLayoutMeasurer >> initializeWith: aParentElement layout: aLinearLayout extentSpec: anExtentSpec orientation: aToTripletLayoutOrientation [

	parent := aParentElement.
	orientation := aToTripletLayoutOrientation.
	layout := aLinearLayout.

	extentSpec := anExtentSpec.
	breadthSpec := orientation breadthSpec: anExtentSpec.
	lengthSpec := orientation lengthSpec: anExtentSpec.

	nodes := aParentElement children accountedByLayout collect: [
			         :aChildElement |
			         ToTripletLayoutNode new
				         initializeWith: aChildElement
				         orientation: orientation ]
]

{ #category : #testing }
ToTripletLayoutMeasurer >> isBreadthExact [
	^ self breadthSpec isExact
]

{ #category : #testing }
ToTripletLayoutMeasurer >> isLengthExact [
	^ self lengthSpec isExact
]

{ #category : #accessing }
ToTripletLayoutMeasurer >> layout [ 

	^ layout
]

{ #category : #accessing }
ToTripletLayoutMeasurer >> lengthSpec [
	^ lengthSpec
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> limitedMeasure [
	| excessSpace remainingExcess remainingNodesCount theLimitedNodes totalLimitedLength maxEachLimitedLength theNodesToShrink totalShrinkedLength |
	
	"Either expand children with weight to take up available space or shrink them if they extend beyond our current bounds.
	If we skipped measurement on any children, we need to measure them now."
	excessSpace := measuredLength - totalLength + usedExcessSpace.
	excessSpace >= 0
		ifTrue: [ ^ self ].

	excessSpace := excessSpace abs.
	remainingExcess := excessSpace.
	
	"we should reduce the size of the fit content limited children"
	theLimitedNodes := self nodes select: [ :eachNode | eachNode lengthResizer isFitContentLimited ].
	theLimitedNodes
		ifEmpty: [ ^ self ].
	
	totalLimitedLength := (theLimitedNodes inject: 0.0 into: [ :aSum :eachNode | aSum + eachNode measuredLength + eachNode marginLength ]) - remainingExcess.
	totalLimitedLength < 0
		ifTrue: [ ^ self ].
	
	maxEachLimitedLength := totalLimitedLength / theLimitedNodes size.
	
	"let's select those nodes that are larger than the max length and need to be schinked"
	theNodesToShrink := theLimitedNodes select: [ :eachNode | eachNode measuredLength > maxEachLimitedLength ].
	theNodesToShrink
		ifEmpty: [ ^ self ].
	
	totalShrinkedLength := (theNodesToShrink inject: 0.0 into: [ :aSum :eachNode | aSum + eachNode measuredLength + eachNode marginLength ]) - remainingExcess.
	totalShrinkedLength < 0
		ifTrue: [ ^ self ].
	
	remainingNodesCount := theNodesToShrink size.
	theNodesToShrink do: [ :eachNode |
			| shareLength childLength childLengthSpec childBreadthSpec |
			
			shareLength := remainingExcess / remainingNodesCount.
			remainingExcess := remainingExcess - shareLength.
			remainingNodesCount := remainingNodesCount - 1.
			
			childLength := eachNode measuredLength - shareLength.
				
			childLengthSpec := BlMeasurementSpec exact: (0.0 max: childLength).
			childBreadthSpec := self childBreadthSpecForNode: eachNode.
				
			 eachNode measure: (orientation extentSpecBreadth: childBreadthSpec lengthSpec: childLengthSpec) ].
		
	measuredLength := measuredLength - excessSpace.
	totalLength := totalLength - excessSpace.
]

{ #category : #'private - measurement' }
ToTripletLayoutMeasurer >> measureExactUsingExcessSpace: aNode [
	"Optimization: don't bother measuring children who are only laid out using excess space.
	These views will get measured later if we have space to distribute."
	
	self subclassResponsibility
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> measureOn: anElement [

	anElement ignoreRequestLayoutDuring: [ self preMeasure ].

	totalLength := totalLength + (orientation paddingLength: parent).
	
	"Check against our minimum length"
	measuredLength := totalLength max: (orientation minimalLength: parent).

	"Reconcile our calculated size with the lengthSpec"
	measuredLength := lengthSpec sizeFor: measuredLength.
	
	self limitedMeasure.
	self weightedMeasure.
	self postMeasure.
	self uniformMeasure
]

{ #category : #accessing }
ToTripletLayoutMeasurer >> nodes [
	<return: #Collection of: #ToTripletLayoutNode>

	^ nodes
]

{ #category : #accessing }
ToTripletLayoutMeasurer >> parent [
	<return: #BlElement>

	^ parent
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> postMeasure [

	maxBreadth := maxBreadth + (orientation paddingBreadth: parent).

	"Check against our minimum height"
	maxBreadth := maxBreadth max: (orientation minimalBreadth: parent).

	parent measuredExtent:
		(orientation
			extentBreadth: (breadthSpec sizeFor: maxBreadth)
			lengthSpec: measuredLength)
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> preMeasure [

	"See how wide/tall everyone is. Also remember max breadth."
	
	self nodes do: [ :aNode |
		| matchBreadthLocally childBreadth shouldUseExcessSpace |

		totalWeight := totalWeight + aNode weight.
		
		"we must store the result because it may temporary change during measurement"
		shouldUseExcessSpace := self shouldUseExcessSpaceForNode: aNode.

		(self canMeasureExactUsingExcessSpaceForNode: aNode)
			ifTrue: [ self measureExactUsingExcessSpace: aNode ]
			ifFalse: [
				| usedLength childLength |
				"The lengthMode is either UNSPECIFIED or AT_MOST, and
				this child is only laid out using excess space.
				Measure using FIT_CONTENT so that we can find out the view's optimal length.
				We'll restore the original length of 0 after measurement."
				shouldUseExcessSpace
					ifTrue: [ aNode lengthResizer: BlLayoutResizer fitContent ].

				"Determine how big this child would like to be.
				If this or previous children have given a weight,
				then we allow it to use all available space (and we will shrink things later if needed)."
				usedLength := totalWeight isZero
					ifTrue: [ totalLength ]
					ifFalse: [ 0 ].
				orientation
					measureChildWithMargin: aNode element
					parentSpec: extentSpec
					breadthUsed: 0
					lengthUsed: usedLength.

				childLength := aNode measuredLength.
				shouldUseExcessSpace
					ifTrue: [
						"Restore the original width and record how much space
						we've allocated to excess-only children so that we can
						match the behavior of EXACTLY measurement."
						aNode lengthResizer: BlLayoutResizer matchParent.
						usedExcessSpace := usedExcessSpace + childLength ].
				
				self updateTotalLengthAfterMeasuring: aNode ].
		
		matchBreadthLocally := false.
		(self isBreadthExact not and: [ aNode breadthResizer isMatchParent ])
			ifTrue: [
				"The height of the linear layout will scale, and at least one child said it wanted to match our height.
				Set a flag indicating that we need to remeasure at least that view when we know our height."
				matchBreadth := true.
				matchBreadthLocally := true ].
		
		childBreadth := aNode measuredBreadth + aNode marginBreadth.

		maxBreadth := maxBreadth max: childBreadth ]
]

{ #category : #'private - measurement' }
ToTripletLayoutMeasurer >> prepareForWeightedMeasure [

		totalLength := 0.0.
]

{ #category : #'accessing - properties' }
ToTripletLayoutMeasurer >> remainingWeightSum [

	^  totalWeight
]

{ #category : #'private - measurement' }
ToTripletLayoutMeasurer >> shouldUseExcessSpaceForNode: aNode [

	^ (lengthSpec isUnspecified not) and: [
		  aNode shouldUseExcessSpace ]
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> uniformMeasure [
	| uniformMeasureSpec |

	matchBreadth
		ifFalse: [ ^ self ].

	"Pretend that the linear layout has an exact size. This is the measured height of ourselves.
	The measured height should be the max height of the children, changed to accommodate the heightMeasureSpec from the parent"
	
	uniformMeasureSpec := BlMeasurementSpec exact: (orientation measuredBreadth: parent).
	
	self nodes
		select: [ :aNode | aNode breadthResizer isMatchParent ]
		thenDo: [ :aNode |
			| oldResizer |
			"Temporarily force children to reuse their old measured width"
			oldResizer := aNode lengthResizer.
			aNode lengthResizer: (BlLayoutResizer exact: aNode measuredLength).
			
			"Remeasure with new dimensions"
			orientation 
				measureChildWithMargin: aNode element
				parentSpec: (orientation 
					extentSpecBreadth: uniformMeasureSpec
					lengthSpec: self lengthSpec)
				breadthUsed: 0
				lengthUsed: 0.
				
			aNode lengthResizer: oldResizer ].
]

{ #category : #'private - measurement' }
ToTripletLayoutMeasurer >> updateTotalLengthAfterMeasuring: aNode [
	"I update the total length after measuring a given node based on its measured length and margin"

	self subclassResponsibility
]

{ #category : #measurement }
ToTripletLayoutMeasurer >> weightedMeasure [

	| remainingExcess remainingWeightSum |
	measuredLength := totalLength max:
		                  (orientation minimalLength: parent).
	measuredLength := lengthSpec sizeFor: measuredLength.
	remainingExcess := measuredLength - totalLength + usedExcessSpace.

	(remainingExcess > 0 and: [ totalWeight > 0 ]) ifFalse: [ ^ self ].
	remainingWeightSum := self remainingWeightSum.

	self prepareForWeightedMeasure.
	
	self nodes do: [ :aNode |
			| childWeight childLength childBreadth matchBreadthLocally |
			childWeight := aNode weight.
			childWeight > 0 ifTrue: [
					| shareSpace childLengthSpec childBreadthSpec |
					shareSpace := (remainingWeightSum closeTo: 0)
						              ifTrue: [ 0.0 ]
						              ifFalse: [
						              (childWeight * remainingExcess
						               / remainingWeightSum) asFloat ].
					remainingExcess := remainingExcess - shareSpace.
					remainingWeightSum := remainingWeightSum - childWeight.
					childLength := aNode lengthResizer isMatchParent
						               ifTrue: [ shareSpace ]
						               ifFalse: [ aNode measuredLength + shareSpace ].
					childLengthSpec := BlMeasurementSpec exact:
						                   (0.0 max: childLength).
					childBreadthSpec := self childBreadthSpecForNode: aNode.
					aNode measure: (orientation
							 extentSpecBreadth: childBreadthSpec
							 lengthSpec: childLengthSpec) ].
			self updateTotalLengthAfterMeasuring: aNode.
			matchBreadthLocally := breadthSpec isExact not and: [
				                       aNode breadthResizer isMatchParent ].
			childBreadth := aNode measuredBreadth + aNode marginBreadth.
			maxBreadth := maxBreadth max: childBreadth ].
	totalLength := totalLength + (orientation paddingLength: parent)
]
