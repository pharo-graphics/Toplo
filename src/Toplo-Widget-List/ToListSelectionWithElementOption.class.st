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

	selectionOption isMasked ifTrue: [ ^ self ].
	selectionContainer addChild: aSelectionElement
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> addSelectionElements: aSelectionElementArray [

	selectionOption isMasked ifTrue: [ ^ self ].
	selectionContainer addChildren: aSelectionElementArray
]

{ #category : #accessing }
ToListSelectionWithElementOption >> addSelectionElementsIn: aListElement startingAt: aPosition [

	| elements |
	elements := Array streamContents: [ :stream |
		            aPosition to: currentSelectionRepresentations size do: [ :p |
			            stream nextPut:
				            ((currentSelectionRepresentations at: p)
					             updatedSelectionElementIn: aListElement) ] ].

	self addSelectionElements: elements
]

{ #category : #adding }
ToListSelectionWithElementOption >> addSelectionIn: aListElement [
	" add new selection with animation if possible. 
	Pay attention, an animation can be used. In case of animation, the SelectedSkinEvent is sent only
	when the animation ends to have a nice visual effect. If no animation is used, then SelectedSkinEvent is
	sent just after the selection is added "

	| finalBounds startBounds |
	currentSelectionRepresentations ifEmpty: [ ^ self ].
	self checkSelectionContainerIn: aListElement.

	currentSelectionRepresentations do: [ :grp |
		grp refreshSelectionElementIn: aListElement option: self ].

	startBounds := previousSelectionBounds.
	finalBounds := currentSelectionRepresentations first
		               preComputedBounds.
	" animation is used if the start and the final bounds differs and in case of one selection group only "
	(startBounds = finalBounds or: [
		 (self canAnimateSelectionUpdate and: [
			  currentSelectionRepresentations size = 1 ]) not ]) ifTrue: [
		self addSelectionElementsIn: aListElement startingAt: 1.
		self notifyNodesSelectedIn: aListElement.
		^ self ].

	self
		boundsAnimationFrom: startBounds
		to: finalBounds
		onRepresentation: currentSelectionRepresentations first
		in: aListElement.

	" add others "
	self addSelectionElementsIn: aListElement startingAt: 2
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> boundsAnimationFrom: startBounds to: finalBounds onRepresentation: aRepresentation in: aListElement [

	| theSelectionElement anim |
	theSelectionElement := aRepresentation selectionElement.
	theSelectionElement size: startBounds extent.
	theSelectionElement position: startBounds origin.
	self addSelectionElement: theSelectionElement.
	anim := ToBoundsTransition new
		  from: startBounds;
		  to: finalBounds;
		  duration: selectionOption animationDuration;
		  onStepDo: [ :aRectangle :target |
			  theSelectionElement size: aRectangle extent.
			  theSelectionElement position: aRectangle origin ];
		  onFinishedDo: [
			  theSelectionElement position: finalBounds origin.
			  theSelectionElement size: finalBounds extent.
			  theSelectionElement whenLayoutedDoOnce: [
					  self notifyNodesSelectedIn: aListElement ] ].
	theSelectionElement addAnimation: anim
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

{ #category : #'nodes collecting' }
ToListSelectionWithElementOption >> launchUpdateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	(super
		 launchUpdateSelectionIn: aListElement
		 withSelectionModel: aSelectionModel) ifFalse: [ ^ false ].

	self addSelectionIn: aListElement.
	self rememberSelectionBoundsIn: aListElement.
	^ true
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

	currentSelectionRepresentations ifEmpty: [ ^ self ].
	previousSelectionBounds := Rectangle merging:
		                           (currentSelectionRepresentations collect: [ :g |
			                            g preComputedBounds ])
]

{ #category : #removing }
ToListSelectionWithElementOption >> removeSelectionContainer [

	selectionContainer ifNotNil: [
		selectionContainer removeFromParent.
		selectionContainer := nil ]
]

{ #category : #accessing }
ToListSelectionWithElementOption >> selectionElements [

	^ Array streamContents: [ :stream |
		  currentSelectionRepresentations do: [ :grp |
			  grp selectionElement ifNotNil: [ :se | stream nextPut: se ] ] ]
]
