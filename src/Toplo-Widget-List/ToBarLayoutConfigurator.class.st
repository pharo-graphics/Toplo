Class {
	#name : #ToBarLayoutConfigurator,
	#superclass : #ToBarConfigurator,
	#instVars : [
		'barElement',
		'nodeScrolling',
		'nodeWrapping',
		'nodeAutoDistribution',
		'horizontal',
		'flowLineUniformWidth'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #visiting }
ToBarLayoutConfigurator >> newTrackLayout [

	^ nodeWrapping
		  ifTrue: [
			(horizontal ifTrue: [ ToBarFlowLayout horizontal ] ifFalse: [ ToBarFlowLayout vertical ])
				  lineUniformWidth: flowLineUniformWidth;
				  yourself ]
		  ifFalse: [
			  horizontal
				  ifTrue: [ BlLinearLayout horizontal ]
				  ifFalse: [ BlLinearLayout vertical ] ]
]

{ #category : #visiting }
ToBarLayoutConfigurator >> visitBarElement: aBarElement [

	barElement := aBarElement.
	nodeScrolling := aBarElement nodeScrolling.
	nodeWrapping := aBarElement nodeWrapping.
	nodeAutoDistribution := aBarElement nodeAutoDistribution.
	horizontal := aBarElement isHorizontal.
	flowLineUniformWidth := aBarElement flowLineUniformWidth. 

	aBarElement isHorizontal
		ifTrue: [
			aBarElement hMatchParent.
			aBarElement vFitContent ]
		ifFalse: [
			aBarElement vMatchParent.
			aBarElement hFitContent ].
	aBarElement innerContainer accept: self
]

{ #category : #visiting }
ToBarLayoutConfigurator >> visitBarNode: aBarNode [

	barElement nodeManager constraintNode: aBarNode
]

{ #category : #visiting }
ToBarLayoutConfigurator >> visitInnerBarElement: anInnerBarElement [

	anInnerBarElement configureLayout.
	anInnerBarElement isHorizontal
		ifTrue: [
			anInnerBarElement hMatchParent.
			anInnerBarElement vFitContent.
			anInnerBarElement middleContainer constraintsDo: [ :c |
				c linear vertical alignCenter.
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			anInnerBarElement hFitContent.
			anInnerBarElement vMatchParent.
			anInnerBarElement middleContainer constraintsDo: [ :c |
				c linear horizontal alignCenter.
				c vertical matchParent.
				c horizontal fitContent ] ].

	anInnerBarElement scrollableElement accept: self
]

{ #category : #visiting }
ToBarLayoutConfigurator >> visitScrollableBarElement: aScrollableBarElement [

	barElement isHorizontal
		ifTrue: [
			aScrollableBarElement constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ] ]
		ifFalse: [
			aScrollableBarElement constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical matchParent ] ].
	aScrollableBarElement trackElement accept: self

]

{ #category : #visiting }
ToBarLayoutConfigurator >> visitScrollableBarTrackElement: aScrollableBarTrackElement [

	aScrollableBarTrackElement nodeScrolling:  nodeScrolling.
	aScrollableBarTrackElement nodeWrapping:  nodeWrapping.
	aScrollableBarTrackElement nodeAutoDistribution:  nodeAutoDistribution.
	aScrollableBarTrackElement horizontal:  horizontal.
	aScrollableBarTrackElement flowLineUniformWidth: flowLineUniformWidth.

	aScrollableBarTrackElement layout: self newTrackLayout.
	aScrollableBarTrackElement constraintsDo: [ :c |
		horizontal
			ifTrue: [
				c vertical fitContent.
				nodeWrapping
					ifTrue: [ c horizontal matchParent ]
					ifFalse: [
						nodeScrolling
							ifTrue: [ c horizontal fitContent ]
							ifFalse: [ c horizontal matchParent ] ] ]
			ifFalse: [
				c horizontal fitContent.
				nodeWrapping
					ifTrue: [ c vertical matchParent ]
					ifFalse: [
						nodeScrolling
							ifTrue: [ c vertical fitContent ]
							ifFalse: [ c vertical matchParent ] ] ] ].
				
	barElement nodeManager constraintFakeNode: aScrollableBarTrackElement fakeNode.
	aScrollableBarTrackElement nodesDo: [ :n | n accept: self ]
]
