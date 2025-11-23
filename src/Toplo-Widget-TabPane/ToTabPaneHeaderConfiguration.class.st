Class {
	#name : #ToTabPaneHeaderConfiguration,
	#superclass : #ToTripletContainerConfiguration,
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

	self configureTabGroupIn: anElement".
	anElement alignCenter: true."
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureTabGroupIn: anElement [

	| tabGroup |
	tabGroup := anElement tabGroup.
	(anElement isStartFlexible or: [ anElement isEndFlexible ]) ifTrue: [
			tabGroup fitContent.
			^ self ].

	anElement isHorizontal
		ifTrue: [
				tabGroup hMatchParent.
				tabGroup vFitContent ]
		ifFalse: [
				tabGroup vMatchParent.
				tabGroup hFitContent ].
	tabGroup isFlowable ifTrue: [ ^ self ].

	matchParentMode
		ifTrue: [ self switchToMatchParentIn: anElement ]
		ifFalse: [ self switchToFitContentIn: anElement ].

	tabGroup selectionModel selectedIndexesDo: [ :idx |
			anElement whenLayoutedDoOnce: [
				tabGroup selecter scrollTowardStartToDataSourcePosition: idx ] ]
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
