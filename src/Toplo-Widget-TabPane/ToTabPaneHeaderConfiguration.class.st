Class {
	#name : #ToTabPaneHeaderConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderConfiguration >> applyOn: anElement [

	super applyOn: anElement.

	self configureAlignmentIn: anElement
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureAlignmentIn: anElement [


	anElement alignment ifNull: [
			startFlexible := false.
			endFlexible := false ].
	anElement alignment = BlElementAlignment start ifTrue: [
			startFlexible := false.
			endFlexible := true ].
	anElement alignment = BlElementAlignment end ifTrue: [
			startFlexible := true.
			endFlexible := false ].
	anElement alignment = BlElementAlignment middle ifTrue: [
			startFlexible := true.
			endFlexible := true ].

	self configureStartFillerIn: anElement.
	self configureEndFillerIn: anElement.
	self configureTabGroupIn: anElement
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureTabGroupIn: anElement [

	(startFlexible or: [ endFlexible ]) ifTrue: [
			anElement tabGroup fitContent.
			anElement middleContainer constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ].
			^ self ].

	anElement isHorizontal
		ifTrue: [
				anElement tabGroup hMatchParent.
				anElement tabGroup vFitContent.
				anElement middleContainer constraintsDo: [ :c |
						c horizontal matchParent.
						c vertical fitContent ] ]
		ifFalse: [
				anElement tabGroup vMatchParent.
				anElement tabGroup hFitContent.
				anElement middleContainer constraintsDo: [ :c |
						c vertical matchParent.
						c horizontal fitContent ] ]
]
