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
	self configureTabGroupIn: anElement.
	anElement alignCenter: true.
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureTabGroupIn: anElement [


	(startFlexible or: [ endFlexible ]) ifTrue: [
			anElement tabGroup fitContent.
			anElement middleContainer hFitContent.
			anElement middleContainer vFitContent.
			^ self ].

	anElement isHorizontal
		ifTrue: [
				anElement tabGroup hMatchParent.
				anElement tabGroup vFitContent.
				anElement middleContainer hMatchParent.
				anElement middleContainer vFitContent ]
		ifFalse: [
				anElement tabGroup vMatchParent.
				anElement tabGroup hFitContent.
				anElement middleContainer vMatchParent.
				anElement middleContainer hFitContent ].
	anElement checkTabGroupDynamicLayoutMode

]
