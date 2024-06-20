Class {
	#name : #ToSegmentedConfigurator,
	#superclass : #ToBarLayoutConfigurator,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #visiting }
ToSegmentedConfigurator >> canMatchParentHorizontallyInVerticalSegmented [

	^ barElement canMatchParentHorizontallyInVerticalSegmented
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitInnerBarElement: anInnerBarElement [

	super visitInnerBarElement: anInnerBarElement.
	anInnerBarElement isHorizontal ifTrue: [ ^ self ].
	self canMatchParentHorizontallyInVerticalSegmented ifFalse: [ ^ self ].
	anInnerBarElement hMatchParent.
	anInnerBarElement middleContainer constraintsDo: [ :c |
		c horizontal matchParent ]
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitScrollableBarElement: aScrollableBarElement [

	super visitScrollableBarElement: aScrollableBarElement.
	aScrollableBarElement isHorizontal ifTrue: [ ^ self ].
	self canMatchParentHorizontallyInVerticalSegmented ifFalse: [ ^ self ].
	aScrollableBarElement hMatchParent
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitScrollableBarTrackElement: aScrollableTrackElement [

	super visitScrollableBarTrackElement: aScrollableTrackElement.
	aScrollableTrackElement constraintsDo: [ :c |
		aScrollableTrackElement isHorizontal ifFalse: [
			self canMatchParentHorizontallyInVerticalSegmented ifFalse: [
				^ self ].
			c horizontal matchParent ] ]
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitSegmentedElement: aSegmentedBarElement [

	self visitBarElement: aSegmentedBarElement.
	aSegmentedBarElement isHorizontal ifTrue: [ ^ self ].
	self canMatchParentHorizontallyInVerticalSegmented ifFalse: [ ^ self ].
	aSegmentedBarElement hMatchParent
]
