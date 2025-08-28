Class {
	#name : #ToTabPaneHeaderConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#instVars : [
		'matchParentMode'
	],
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

	matchParentMode
		ifTrue: [ self switchToMatchParentIn: anElement ]
		ifFalse: [ self switchToFitContentIn: anElement ]
]

{ #category : #initialization }
ToTabPaneHeaderConfiguration >> initialize [ 

	super initialize.
	matchParentMode := true
]

{ #category : #accessing }
ToTabPaneHeaderConfiguration >> matchParentMode [

	^ matchParentMode
]

{ #category : #accessing }
ToTabPaneHeaderConfiguration >> matchParentMode: aBoolean [

	matchParentMode := aBoolean
]

{ #category : #'private - layout managing' }
ToTabPaneHeaderConfiguration >> switchToFitContentIn: anHeaderElement [

	anHeaderElement trackElement
		allParentsUpTo: anHeaderElement tabGroup
		do: [ :p |
				anHeaderElement isHorizontal
					ifTrue: [ p hFitContent ]
					ifFalse: [ p vFitContent ] ]
]

{ #category : #'private - layout managing' }
ToTabPaneHeaderConfiguration >> switchToMatchParentIn: anHeaderElement [

	anHeaderElement trackElement
		allParentsUpTo: anHeaderElement tabGroup
		do: [ :p |
				anHeaderElement isHorizontal
					ifTrue: [ p hMatchParent ]
					ifFalse: [ p vMatchParent ] ]
]
