Class {
	#name : #ToSegmentedConfigurator,
	#superclass : #ToBarLayoutConfigurator,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #visiting }
ToSegmentedConfigurator >> visitInnerBarElement: anInnerBarElement [

	super visitInnerBarElement: anInnerBarElement.
	self wantsHMatchParent ifFalse: [ ^ self ].
	anInnerBarElement hMatchParent.
	anInnerBarElement middleContainer constraintsDo: [ :c |
		c horizontal matchParent ]
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitScrollableBarElement: aScrollableBarElement [

	super visitScrollableBarElement: aScrollableBarElement.
	self wantsHMatchParent ifFalse: [ ^ self ].
	aScrollableBarElement hMatchParent
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitScrollableBarTrackElement: aScrollableTrackElement [

	super visitScrollableBarTrackElement: aScrollableTrackElement.
	aScrollableTrackElement constraintsDo: [ :c |
		self wantsHMatchParent ifFalse: [ ^ self ].
		c horizontal matchParent ]
]

{ #category : #visiting }
ToSegmentedConfigurator >> visitSegmentedElement: aSegmentedBarElement [

	self visitBarElement: aSegmentedBarElement.
	self wantsHMatchParent ifFalse: [ ^ self ].
	aSegmentedBarElement hMatchParent
]

{ #category : #visiting }
ToSegmentedConfigurator >> wantsHMatchParent [

	^ barElement wantsHMatchParent
]
