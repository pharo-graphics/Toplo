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
ToSelectionGroupHolder >> addSelectionElements: aSelectionElementArray [

	| first |
	animation ifNotNil: [
		animation isRunning ifTrue: [ animation stop ].
		animation := nil ].
	aSelectionElementArray ifEmpty: [ ^ self ].
	self canAnimateSelectionUpdate
		ifTrue: [
			| targetBounds startBounds |
			'animate' traceCr.
			first := aSelectionElementArray first.
			first position: previousSelectionBounds origin.
			first size: previousSelectionBounds extent.
			startBounds := previousSelectionBounds.
			targetBounds := first boundsFromNodes.
			animation := ToBoundsTransition new
				             from: startBounds;
				             to: targetBounds;
				             duration: option animationDuration;
				             onStepDo: [ :anArray :target |
					             first position: anArray origin.
					             first size: anArray extent ].
			first addAnimation: animation.
			first updateListElement.
			self addSelectionElements: aSelectionElementArray startingAt: 2 ]
		ifFalse: [
		self addSelectionElements: aSelectionElementArray startingAt: 1 ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> addSelectionElements: aSelectionElementArray startingAt: aPosition [

	aPosition to: aSelectionElementArray size do: [ :p |
	(aSelectionElementArray at: p) computeBounds ].
	aPosition to: aSelectionElementArray size do: [ :p |
	(aSelectionElementArray at: p) updateListElement ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdate [

	^ option animationDuration isZero not and: [previousSelectionBounds notNil]
]

{ #category : #enumerating }
ToSelectionGroupHolder >> collectSelectionElementsFrom: aListElement [

	^ groups collect: [ :grp |
		  grp createSelectionElementFrom: aListElement ]
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

{ #category : #accessing }
ToSelectionGroupHolder >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> refreshSelectionFrom: aListElement [

	self updateSelectionFrom: aListElement withAnimation: false
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberStateWith: aCollectionOfSelectionElements [

	previousSelectionBounds := aCollectionOfSelectionElements first boundsFromNodes merge:
		                           aCollectionOfSelectionElements last boundsFromNodes
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> removeSelectionElements [

	groups ifNotNil: [ groups do: [ :grp | grp removeSelectionElement ] ].
	groups := #(  )
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> renewSelectionFrom: aListElement [

	self removeSelectionElements.
	groups := Array streamContents: [ :stream |
		                 option nextPutSelectionGroupsFrom: aListElement in: stream ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionFrom: aListElement [

	self updateSelectionFrom: aListElement withAnimation: true
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionFrom: aListElement withAnimation: animationRequested [

	| selElements |
	animationRequested ifFalse: [ self forgetPreviousState ].
	self renewSelectionFrom: aListElement.
	selElements := self collectSelectionElementsFrom: aListElement.
	self addSelectionElements: selElements.
	selElements ifEmpty: [
		self forgetPreviousState.
		^ self ].
	animationRequested ifTrue: [ self rememberStateWith: selElements ]
]
