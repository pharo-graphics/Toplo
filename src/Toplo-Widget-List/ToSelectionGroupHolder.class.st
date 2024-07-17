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
ToSelectionGroupHolder >> addSelectionElementsIn: aListElement startingAt: aPosition [

	| elements |
	elements := Array streamContents: [ :stream |
		            aPosition to: groups size do: [ :p |
			            stream nextPut:
				            ((groups at: p) updatedSelectionElementIn:
					             aListElement) ] ].

	option addSelectionElements: elements
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> addSelectionIn: aListElement [

	| first finalBounds startBounds |
	self notifyNodesDeselectedIn: aListElement.

	groups ifEmpty: [ ^ self ].
	(self canAnimateSelectionUpdate and: [ groups size = 1 ])
		ifFalse: [
			self addSelectionElementsIn: aListElement startingAt: 1.
			self notifyNodesSelectedIn: aListElement.
			^ self ].

	startBounds := previousSelectionBounds.
	first := groups first selectionElement.
	first position: startBounds origin.
	first size: startBounds extent.
	finalBounds := groups first preComputedBounds.

	animation := self
		             boundsAnimationFrom: startBounds
		             to: finalBounds
		             onGroup: groups first
		             in: aListElement.

	first addAnimation: animation.
	" directly add the selection element without computing its bounds "
	option addSelectionElement: first.
	" add others "
	self addSelectionElementsIn: aListElement startingAt: 2
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> boundsAnimationFrom: startBounds to: finalBounds onGroup: aGroup in: aListElement [

	| theSelectionElement |
	theSelectionElement := aGroup selectionElement.
	^ ToBoundsTransition new
		  from: startBounds;
		  to: finalBounds;
		  duration: option animationDuration;
		  onStepDo: [ :anArray :target |
			  theSelectionElement position: anArray origin.
			  theSelectionElement size: anArray extent ];
		  onFinishedDo: [
			  theSelectionElement position: finalBounds position.
			  theSelectionElement size: finalBounds extent.
			  theSelectionElement whenLayoutedDoOnce: [
					  self notifyNodesSelectedIn: aListElement. ] ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdate [

	^ option animationDuration isZero not and: [previousSelectionBounds notNil]
]

{ #category : #enumerating }
ToSelectionGroupHolder >> createSelectionElementsFrom: aListElement [

	groups do: [ :grp |
		  grp refreshSelectionElementIn: aListElement option: option]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> forgetPreviousBoundsIn: aListElement [

	previousSelectionBounds := nil.

]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> groups: aGroups equals: otherGroup [

	aGroups == otherGroup ifTrue: [ ^ true ].
	aGroups size ~= otherGroup size ifTrue: [ ^ false ].
	aGroups withIndexDo: [ :g :idx |
		g = (otherGroup at: idx) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #initialization }
ToSelectionGroupHolder >> initialize [

	super initialize.
	groups := #(  )
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> newGroups: aGroupArray in: aListElement [
 
	self removeSelectionIn: aListElement.
	groups := aGroupArray.
	option masked ifTrue: [ 
		self notifyNodesDeselectedIn: aListElement.
		self notifyNodesSelectedIn: aListElement.
		^ self ].
	self createSelectionElementsFrom: aListElement.
	self addSelectionIn: aListElement.
	self rememberSelectionBoundsIn: aListElement
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> notifyNodesDeselectedIn: aListElement [

	option triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerContainer nodesDo: [ :n | n holder notifyDeselected ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> notifyNodesSelectedIn: aListElement [

	option triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerContainer nodesDo: [ :n | n holder notifySelected ]
]

{ #category : #accessing }
ToSelectionGroupHolder >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> refreshGroupsIn: aListElement [

	groups := #()
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> refreshSelectionIn: aListElement [

	self forgetPreviousBoundsIn: aListElement.
	self removeSelectionIn: aListElement.
	self refreshGroupsIn: aListElement.
	self updateSelectionIn: aListElement 
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberSelectionBoundsIn: aListElement [

	groups ifEmpty: [ ^ self ].
	previousSelectionBounds := Rectangle merging: (groups collect: [:g | g preComputedBounds])
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> removeSelectionIn: aListElement [

	groups do: [ :g | g removeSelectionElementIn: aListElement ].

]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionIn: aListElement [

	| newGroups |
	"option selectionMode selecter selectionChangedEventClass = ToListDisabledSelectionChangedEvent ifTrue: [self haltOnce]."
	"'updateSelectionIn: ' trace. option selectionMode selecter selectionChangedEventClass traceCr."
	newGroups := option collectSelectionGroupsFrom: aListElement.
	(self groups: groups equals: newGroups) ifTrue: [ ^ self ].
	self newGroups: newGroups in: aListElement
]
