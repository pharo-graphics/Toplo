Class {
	#name : #ToListSelectionWithElementOption,
	#superclass : #ToListSelectionRepresentationOption,
	#instVars : [
		'previousSelectionBounds',
		'selectionContainer'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> addSelectionElement: aSelectionElement [

	selectionContainer addChild: aSelectionElement
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> addSelectionElements: aSelectionElementArray [

	selectionContainer addChildren: aSelectionElementArray
]

{ #category : #accessing }
ToListSelectionWithElementOption >> addSelectionElementsIn: aListElement startingAt: aPosition [

	| elements |
	self checkSelectionContainerIn: aListElement.
	elements := Array streamContents: [ :stream |
		            aPosition to: currentSelectionGroups size do: [ :p |
			            stream nextPut:
				            ((currentSelectionGroups at: p)
					             updatedSelectionElementIn: aListElement) ] ].

	self addSelectionElements: elements
]

{ #category : #adding }
ToListSelectionWithElementOption >> addSelectionIn: aListElement [ 
	" add new selection with animation if possible. 
	Pay attention, an animation can be used. In case of animation, the SelectedSkinEvent is sent only
	when the animation ends to have a nice visual effect. If no animation is used, then SelectedSkinEvent is
	sent just after the selection is added "

	| first finalBounds startBounds animation |

	" send deselected first even groups is empty. 
	As an example, if not, if a selected node is turned as unselectable, 
	the content of the node will not be updated correctly 
	because the content skin will not receive the DeselectedSkinEvent "
	self notifyNodesDeselectedIn: aListElement.

	currentSelectionGroups ifEmpty: [ ^ self ].
	currentSelectionGroups do: [ :grp |
		grp
			refreshSelectionElementIn: aListElement
			option: self ].

	startBounds := previousSelectionBounds.
	finalBounds := currentSelectionGroups first preComputedBounds.
	" animation is used if the start and the final bounds differs and in case of one selection group only "
	(startBounds = finalBounds or: [
		 (self canAnimateSelectionUpdate and: [ currentSelectionGroups size = 1 ]) not ])
		ifTrue: [
			self addSelectionElementsIn: aListElement startingAt: 1.
			self notifyNodesSelectedIn: aListElement.
			^ self ].

	first := currentSelectionGroups first selectionElement.
	first position: startBounds origin.
	first size: startBounds extent.

	animation := self
		             boundsAnimationFrom: startBounds
		             to: finalBounds
		             onGroup: currentSelectionGroups first
		             in: aListElement.

	first addAnimation: animation.
	" directly add the selection element without computing its bounds "
	self checkSelectionContainerIn: aListElement.
	self addSelectionElement: first.
	" add others "
	self addSelectionElementsIn: aListElement startingAt: 2
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> boundsAnimationFrom: startBounds to: finalBounds onGroup: aGroup in: aListElement [

	| theSelectionElement |
	theSelectionElement := aGroup selectionElement.
	^ ToBoundsTransition new
		  from: startBounds;
		  to: finalBounds;
		  duration: selectionOption animationDuration;
		  onStepDo: [ :anArray :target |
			  theSelectionElement position: anArray origin.
			  theSelectionElement size: anArray extent ];
		  onFinishedDo: [
			  theSelectionElement position: finalBounds origin.
			  theSelectionElement size: finalBounds extent.
			  theSelectionElement whenLayoutedDoOnce: [
					  self notifyNodesSelectedIn: aListElement. ] ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> canAnimateSelectionUpdate [

	^ self isAnimated and: [ previousSelectionBounds notNil ]
]

{ #category : #accessing }
ToListSelectionWithElementOption >> checkSelectionContainerIn: aListElement [

	selectionContainer ifNil: [
		selectionContainer := self newSelectionContainerIn: aListElement.
		aListElement addChild: selectionContainer ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> forgetPreviousBoundsIn: aListElement [

	previousSelectionBounds := nil
]

{ #category : #testing }
ToListSelectionWithElementOption >> isAnimated [

	^ selectionOption isAnimated 
]

{ #category : #accessing }
ToListSelectionWithElementOption >> isBeneath [

	^ selectionOption isBeneath 
]

{ #category : #'instance creation' }
ToListSelectionWithElementOption >> newSelectionContainerIn: aListElement [

	| container elevation |
	container := ToOverlayElement new.
	container clipChildren: false.
	container attachTo: aListElement innerElement.
	elevation := self isBeneath
		             ifTrue: [ BlRelativeElevation elevation: 5 ]
		             ifFalse: [ BlRelativeElevation elevation: 15 ].
	container elevation: elevation.
	^ container
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> newSelectionElementIn: aListElement [

	^ selectionOption elementFactory value
		  listElement: aListElement;
		  selectionOption: self;
		  focused: aListElement isFocused;
		  yourself
]

{ #category : #'nodes collecting' }
ToListSelectionWithElementOption >> refreshSelectionIn: aListElement withSelectionModel: aSelectionModel [

	self forgetPreviousBoundsIn: aListElement.
	super
		refreshSelectionIn: aListElement
		withSelectionModel: aSelectionModel
]

{ #category : #'nodes collecting' }
ToListSelectionWithElementOption >> rememberSelectionBoundsIn: aListElement [

	currentSelectionGroups ifEmpty: [ ^ self ].
	previousSelectionBounds := Rectangle merging:
		                           (currentSelectionGroups collect: [ :g |
			                            g preComputedBounds ])
]

{ #category : #accessing }
ToListSelectionWithElementOption >> selectionElements [

	^ Array streamContents: [ :stream |
		  currentSelectionGroups do: [ :grp |
			  grp selectionElement ifNotNil: [ :se | stream nextPut: se ] ] ]
]

{ #category : #'nodes collecting' }
ToListSelectionWithElementOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	(super
		 updateSelectionIn: aListElement
		 withSelectionModel: aSelectionModel) ifFalse: [ ^ false ].
	self isMasked ifTrue: [ ^ false ].
	self addSelectionIn: aListElement.
	self rememberSelectionBoundsIn: aListElement.
	^ true
]
