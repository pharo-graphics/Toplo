Class {
	#name : #ToSelectionGroupHolder,
	#superclass : #Object,
	#instVars : [
		'groups',
		'option',
		'previousSelectionBounds',
		'animation'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> addSelectionElement: aSelectionElement in: aListElement [

	aSelectionElement computeBoundsIn: aListElement.
	self isBeneath
		ifTrue: [
		aListElement addBeneathSelectionElement: aSelectionElement ]
		ifFalse: [ aListElement addOverSelectionElement: aSelectionElement ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> addSelectionElements: aSelectionElementArray in: aListElement startingAt: aPosition [

	| elements |
	elements := aSelectionElementArray
		            copyFrom: aPosition
		            to: aSelectionElementArray size.

	elements do: [ :aSelectionElement |
		aSelectionElement computeBoundsIn: aListElement ].
	self isBeneath
		ifTrue: [ aListElement addBeneathSelectionElements: elements ]
		ifFalse: [ aListElement addOverSelectionElements: elements ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdate [

	^ option animationDuration isZero not and: [previousSelectionBounds notNil]
]

{ #category : #enumerating }
ToSelectionGroupHolder >> collectNewSelectionElementsIn: aListElement [

	^ groups collect: [ :grp |
		  grp createSelectionElementFor: aListElement ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> forgetPreviousState [

	previousSelectionBounds := nil
]

{ #category : #accessing }
ToSelectionGroupHolder >> groups [

	^ groups
]

{ #category : #initialization }
ToSelectionGroupHolder >> initialize [ 

	super initialize.
	groups := #()
]

{ #category : #testing }
ToSelectionGroupHolder >> isBeneath [ 

	^ option isBeneath 
]

{ #category : #accessing }
ToSelectionGroupHolder >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> refreshSelectionIn: aListElement [

	self updateSelectionIn: aListElement withAnimation: false
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberStateWith: aCollectionOfSelectionElements in: aListElement [

	previousSelectionBounds := (aCollectionOfSelectionElements first
		                            boundsFromNodesIn: aListElement) merge:
		                           (aCollectionOfSelectionElements last
			                            boundsFromNodesIn: aListElement)
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> removeSelectionElements [

	groups ifNotNil: [ groups do: [ :grp | grp removeSelectionElement ] ].
	groups := #(  )
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> renewSelectionIn: aListElement [

	self removeSelectionElements.
	groups := Array streamContents: [ :stream |
		                 option nextPutSelectionGroupsFrom: aListElement in: stream ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionIn: aListElement [

	self updateSelectionIn: aListElement withAnimation: true
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionIn: aListElement withAnimation: animationRequested [

	| selElements |
	animationRequested ifFalse: [ self forgetPreviousState ].
	self renewSelectionIn: aListElement.
	selElements := self collectNewSelectionElementsIn: aListElement.
	self updateSelectionWith: selElements in: aListElement.
	"selElements ifEmpty: [
		self forgetPreviousState.
		^ self ]."
	selElements ifEmpty: [ ^ self ].
	animationRequested ifTrue: [ self rememberStateWith: selElements in: aListElement]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionWith: aSelectionElementArray in: aListElement [

	| first |
	animation ifNotNil: [
		animation isRunning ifTrue: [ animation stop ].
		animation := nil ].

	aSelectionElementArray ifEmpty: [ ^ self ].

	(self canAnimateSelectionUpdate and: [
		 aSelectionElementArray size = 1 ]) ifTrue: [
		| targetBounds startBounds |
		first := aSelectionElementArray first.
		first position: previousSelectionBounds origin.
		first size: previousSelectionBounds extent.
		startBounds := previousSelectionBounds.
		targetBounds := first boundsFromNodesIn: aListElement.
		animation := ToBoundsTransition new
			             from: startBounds;
			             to: targetBounds;
			             duration: option animationDuration;
			             onStepDo: [ :anArray :target |
				             first position: anArray origin.
				             first size: anArray extent ].
		first addAnimation: animation.
		" directly add the selection element without computing its bounds "
		self isBeneath
			ifTrue: [ aListElement addBeneathSelectionElement: first ]
			ifFalse: [ aListElement addOverSelectionElement: first ].
		" add others "
		self
			addSelectionElements: aSelectionElementArray
			in: aListElement
			startingAt: 2.
		^ self ].
	self
		addSelectionElements: aSelectionElementArray
		in: aListElement
		startingAt: 1
]
