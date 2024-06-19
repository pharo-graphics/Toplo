Class {
	#name : #ToSelectionGroupHolder,
	#superclass : #Object,
	#instVars : [
		'groups',
		'option',
		'previousSelectionBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdate [

	^ option animationDuration isZero not and: [previousSelectionBounds notNil]
]

{ #category : #enumerating }
ToSelectionGroupHolder >> collectSelectionElementsFrom: aListElement [

	^ 
		groups collect: [ :grp | grp createSelectionElementFrom: aListElement]
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

	self
		forgetPreviousState;
		updateSelectionFrom: aListElement
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberStateWith: aCollectionOfSelectionElements [

	previousSelectionBounds := aCollectionOfSelectionElements first boundsFromNodes merge:
		                           aCollectionOfSelectionElements last boundsFromNodes
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> renewSelectionFrom: aListElement [

	groups ifNotNil: [groups do: [ :grp | grp removeSelectionElement ] ].
	groups := Array streamContents: [ :stream |
		                 option nextPutSelectionGroupsFrom: aListElement in: stream ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionElements: aSelectionElementArray [

	| first |

	aSelectionElementArray ifEmpty: [ ^ self ].
	self canAnimateSelectionUpdate 
		ifTrue: [
			| targetBounds anim startBounds |
			first := aSelectionElementArray first.
			first position: previousSelectionBounds origin.
			first size: previousSelectionBounds extent.
			startBounds := previousSelectionBounds.
			targetBounds := first boundsFromNodes.
			anim := ToBoundsTransition new
				        from: startBounds;
				        to: targetBounds;
				        duration: option animationDuration;
				        onStepDo: [ :anArray :target |
					        first position: anArray origin.
					        first size: anArray extent ].
			anim onFinishedDo: [
				first position: targetBounds position.
				first size: targetBounds extent.
				self updateSelectionElements: aSelectionElementArray startingAt: 2].
			first addAnimation: anim.
			first updateListElement ]
		ifFalse: [
		self updateSelectionElements: aSelectionElementArray startingAt: 1 ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionElements: aSelectionElementArray startingAt: aPosition [

	aPosition to: aSelectionElementArray size do: [ :p |
		(aSelectionElementArray at: p)
			updateListElement;
			computeBounds ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionFrom: aListElement [

	| selElements |
	self renewSelectionFrom: aListElement.
	selElements := self collectSelectionElementsFrom: aListElement.
	self updateSelectionElements: selElements.
	selElements ifEmpty: [
		self forgetPreviousState.
		^ self ].
	self rememberStateWith: selElements
]
