Class {
	#name : #ToTabPaneHeaderConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderConfiguration >> applyOn: anElement [

	super applyOn: anElement.
	anElement isHorizontal
		ifTrue: [
				anElement hMatchParent.
				anElement vFitContent ]
		ifFalse: [
				anElement vMatchParent.
				anElement hFitContent ].
	self configureAlignmentIn: anElement
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureAlignmentIn: anElement [

	anElement alignment ifNull: [
			anElement startFlexible: false.
			anElement endFlexible: false ].
	anElement alignment = BlElementAlignment start ifTrue: [
			anElement startFlexible: false.
			anElement endFlexible: true  ].
	anElement alignment = BlElementAlignment end ifTrue: [
			anElement startFlexible: true.
			anElement endFlexible: false  ].
	anElement alignment = BlElementAlignment middle ifTrue: [
			anElement startFlexible: true.
			anElement endFlexible: true  ].

	self configureTabGroupIn: anElement.
	anElement alignCenter: true.
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureTabGroupIn: anElement [

	(anElement isStartFlexible or: [ anElement isEndFlexible ]) ifTrue: [
			anElement tabGroup fitContent.
			anElement middleContainer fitContent.
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
