Class {
	#name : #ToSelectionGroupHolder,
	#superclass : #Object,
	#instVars : [
		'groups',
		'option',
		'previousSelectionBounds',
		'animation',
		'selectionElements'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> addSelectionElementsIn: aListElement startingAt: aPosition [

	| elements |
	elements := selectionElements 
		            copyFrom: aPosition
		            to: selectionElements size.

	elements do: [ :aSelectionElement |
		aSelectionElement computeBoundsIn: aListElement ].
	self isBeneath
		ifTrue: [ aListElement addBeneathSelectionElements: elements ]
		ifFalse: [ aListElement addOverSelectionElements: elements ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> addSelectionIn: aListElement [

	| first finalBounds startBounds |
	self notifyNodesDeselectedIn: aListElement.

	selectionElements ifEmpty: [ ^ self ].

	(self canAnimateSelectionUpdate and: [ selectionElements size = 1 ])
		ifFalse: [
			self addSelectionElementsIn: aListElement startingAt: 1.
			self notifyNodesSelectedIn: aListElement.
			^ self ].

	startBounds := previousSelectionBounds.
	first := selectionElements first.
	first position: startBounds origin.
	first size: startBounds extent.
	finalBounds := first boundsFromNodesIn: aListElement.

	animation := self
		             boundsAnimationFrom: startBounds
		             to: finalBounds
		             onSelectionElement: first
		             in: aListElement.

	first addAnimation: animation.
	" directly add the selection element without computing its bounds "
	self isBeneath
		ifTrue: [ aListElement addBeneathSelectionElement: first ]
		ifFalse: [ aListElement addOverSelectionElement: first ].
	" add others "
	self addSelectionElementsIn: aListElement startingAt: 2
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> boundsAnimationFrom: startBounds to: finalBounds onSelectionElement: aSelectionElement in: aListElement [

	^ ToBoundsTransition new
		  from: startBounds;
		  to: finalBounds;
		  duration: option animationDuration;
		  onStepDo: [ :anArray :target |
			  aSelectionElement position: anArray origin.
			  aSelectionElement size: anArray extent ];
		  onFinishedDo: [
			  aSelectionElement position: finalBounds position.
			  aSelectionElement size: finalBounds extent.
			  option isPrimary ifTrue: [
					  aSelectionElement whenLayoutedDoOnce: [
							  aSelectionElement nodes do: [ :n |
									  n holder ensureNotifySelected ] ] ] ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdate [

	^ option animationDuration isZero not and: [previousSelectionBounds notNil]
]

{ #category : #enumerating }
ToSelectionGroupHolder >> collectNewSelectionElementsFrom: aListElement [

	^ groups collect: [ :grp |
		  grp createSelectionElementIn: aListElement ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> forgetPreviousBoundsIn: aListElement [

	previousSelectionBounds := nil.
	self removeSelection.
	groups := #(  )
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> forgetPreviousStateIn: aListElement [

	previousSelectionBounds := nil.
	self removeSelection.
	groups := #(  )
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> forgetSelectionStateIn: aListElement [

	option isPrimary ifTrue: [
		aListElement innerContainer nodesDo: [ :node |
			node holder forgetSelection ] ].
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
	groups := #(  ).
	selectionElements := #(  )
]

{ #category : #testing }
ToSelectionGroupHolder >> isBeneath [ 

	^ option isBeneath 
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> notifyNodesDeselectedIn: aListElement [

	option isPrimary ifFalse: [ ^ self ].
	aListElement innerContainer nodesDo: [ :n | n holder notifyDeselected ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> notifyNodesSelectedIn: aListElement [

	option isPrimary ifFalse: [ ^ self ].
	aListElement innerContainer nodesDo: [ :n | n holder notifySelected ]
]

{ #category : #accessing }
ToSelectionGroupHolder >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> refreshSelectionIn: aListElement [

	self forgetPreviousBoundsIn: aListElement.
	self forgetSelectionStateIn: aListElement.
	self updateSelectionIn: aListElement
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberSelectionBoundsIn: aListElement [

	selectionElements ifEmpty: [ ^ self ].
	previousSelectionBounds := (selectionElements first
		                            boundsFromNodesIn: aListElement) merge:
		                           (selectionElements last
			                            boundsFromNodesIn: aListElement)
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberSelectionStateIn: aListElement [

	option isPrimary ifTrue: [
		aListElement innerContainer nodesDo: [ :node |
			node holder rememberSelection ] ].
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> removeSelection [

	selectionElements do: [ :s | s removeFromParent ].

]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> selectionGroupsChangedIn: aListElement [

	self removeSelection.
	selectionElements := self collectNewSelectionElementsFrom:
		                     aListElement.
	self addSelectionIn: aListElement.
	self rememberSelectionBoundsIn: aListElement
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionIn: aListElement [

	| prevGroups |
	prevGroups := groups.
	groups := option collectSelectionGroupsFrom: aListElement.
	(self groups: prevGroups equals: groups) ifFalse: [
		self selectionGroupsChangedIn: aListElement ].
	self rememberSelectionStateIn: aListElement
]
