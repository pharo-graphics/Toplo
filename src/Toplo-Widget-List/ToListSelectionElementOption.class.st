Class {
	#name : #ToListSelectionElementOption,
	#superclass : #Object,
	#instVars : [
		'masked',
		'grouped',
		'beneath',
		'triggerSelectionState',
		'animationDuration',
		'selectionContainer',
		'elementFactory',
		'previousSelectionBounds',
		'currentSelectionGroups'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionElementOption class >> grouped [

	^ self new grouped: true
]

{ #category : #'instance creation' }
ToListSelectionElementOption class >> separate [

	^ self new grouped: false
]

{ #category : #'instance creation' }
ToListSelectionElementOption >> addSelectionElement: aSelectionElement [

	selectionContainer addChild: aSelectionElement
]

{ #category : #'instance creation' }
ToListSelectionElementOption >> addSelectionElements: aSelectionElementArray [

	selectionContainer addChildren: aSelectionElementArray
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> addSelectionElementsIn: aListElement startingAt: aPosition [

	| elements |
	elements := Array streamContents: [ :stream |
		            aPosition to: currentSelectionGroups size do: [ :p |
			            stream nextPut:
				            ((currentSelectionGroups at: p) updatedSelectionElementIn:
					             aListElement) ] ].

	self addSelectionElements: elements
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> addSelectionIn: aListElement [ 
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
	self addSelectionElement: first.
	" add others "
	self addSelectionElementsIn: aListElement startingAt: 2
]

{ #category : #accessing }
ToListSelectionElementOption >> animationDuration: aDuration [

	animationDuration := aDuration
]

{ #category : #accessing }
ToListSelectionElementOption >> beneath: aBoolean [

	beneath := aBoolean.
	selectionContainer ifNotNil: [
		| elevation |
		elevation := beneath
			             ifTrue: [ BlRelativeElevation elevation: 5 ]
			             ifFalse: [ BlRelativeElevation elevation: 15 ].
		selectionContainer elevation: elevation ]
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> boundsAnimationFrom: startBounds to: finalBounds onGroup: aGroup in: aListElement [

	| theSelectionElement |
	theSelectionElement := aGroup selectionElement.
	^ ToBoundsTransition new
		  from: startBounds;
		  to: finalBounds;
		  duration: animationDuration;
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
ToListSelectionElementOption >> canAnimateSelectionUpdate [

	^ animationDuration isZero not and: [ previousSelectionBounds notNil ]
]

{ #category : #'nodes collecting' }
ToListSelectionElementOption >> currentSelectionGroupsFrom: aListElement withSelectionModel: aSelectionModel [

	^ grouped
		  ifTrue: [
			  (aListElement innerContainer nodeGroupsSatisfying: [ :node |
				   aSelectionModel containsIndex: node holder position ]) collect: [
				  :arr | ToNeighboringSelection new nodes: arr ] ]
		  ifFalse: [
			  (aListElement innerContainer nodesSelect: [ :node |
				   aSelectionModel containsIndex: node holder position ]) collect: [
				  :node | ToSeparateSelection new node: node ] ]
]

{ #category : #accessing }
ToListSelectionElementOption >> elementFactory: aSelectionElementFactoryValuable [

	elementFactory := aSelectionElementFactoryValuable
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> forgetPreviousBoundsIn: aListElement [

	previousSelectionBounds := nil
]

{ #category : #accessing }
ToListSelectionElementOption >> grouped: aBoolean [

	grouped := aBoolean
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> groups: aSelectionGroupArray equals: otherSelectionGroupArray [

	currentSelectionGroups == otherSelectionGroupArray ifTrue: [ ^ true ].
	currentSelectionGroups size ~= otherSelectionGroupArray size ifTrue: [ ^ false ].
	currentSelectionGroups withIndexDo: [ :g :idx |
		g = (otherSelectionGroupArray at: idx) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #initialization }
ToListSelectionElementOption >> initialize [ 

	super initialize.
	currentSelectionGroups := #(  ).
	triggerSelectionState := false.
	animationDuration := 0 milliSecond.
	masked := false.
	beneath := true.
	grouped := false
]

{ #category : #accessing }
ToListSelectionElementOption >> isAnimated [

	^ animationDuration asMilliSeconds > 0
]

{ #category : #testing }
ToListSelectionElementOption >> isBeneath [

	^ beneath
]

{ #category : #testing }
ToListSelectionElementOption >> isGrouped [

	^ grouped
]

{ #category : #testing }
ToListSelectionElementOption >> isOver [

	^ self isBeneath not
]

{ #category : #testing }
ToListSelectionElementOption >> isSeparate [

	^ self isGrouped not
]

{ #category : #accessing }
ToListSelectionElementOption >> masked: aBoolean [

	masked := aBoolean
]

{ #category : #'instance creation' }
ToListSelectionElementOption >> newSelectionContainerIn: aListElement [

	| container elevation |
	container := ToOverlayElement new.
	container clipChildren: false.
	container attachTo: aListElement innerContainer.
	elevation := beneath
		             ifTrue: [ BlRelativeElevation elevation: 5 ]
		             ifFalse: [ BlRelativeElevation elevation: 15 ].
	container elevation: elevation.
	^ container
]

{ #category : #'instance creation' }
ToListSelectionElementOption >> newSelectionElementIn: aListElement [

	^ elementFactory value
		  selectionOption: self;
		  focused: (triggerSelectionState and: [ aListElement isFocused ]);
		  yourself
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> notifyNodesDeselectedIn: aListElement [

	triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerContainer nodesDo: [ :n | n holder notifyDeselectedWithOption: self ]
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> notifyNodesSelectedIn: aListElement [

	masked ifTrue: [ ^ self ].
	triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerContainer nodesDo: [ :n | n holder notifySelectedWithOption: self ]
]

{ #category : #'api - hooks' }
ToListSelectionElementOption >> onInstalledIn: aListElement [

	selectionContainer := self newSelectionContainerIn: aListElement.
	aListElement addChild: selectionContainer
]

{ #category : #'api - hooks' }
ToListSelectionElementOption >> onUninstalledIn: aListElement [

	selectionContainer detach.
	selectionContainer removeFromParent.
	selectionContainer := nil
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> refreshSelectionIn: aListElement withSelectionModel: aSelectionModel [

	self forgetPreviousBoundsIn: aListElement.
	self removeSelectionIn: aListElement.
	self
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> rememberSelectionBoundsIn: aListElement [

	currentSelectionGroups ifEmpty: [ ^ self ].
	previousSelectionBounds := Rectangle merging: (currentSelectionGroups collect: [:g | g preComputedBounds])
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> removeSelectionIn: aListElement [

	currentSelectionGroups do: [ :g | g removeSelectionElementIn: aListElement ].
	currentSelectionGroups := #()
]

{ #category : #accessing }
ToListSelectionElementOption >> selectionElements [

	^ Array streamContents: [ :stream |
		  currentSelectionGroups do: [ :grp |
			  grp selectionElement ifNotNil: [ :se | stream nextPut: se ] ] ]
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> selectionGroupsChangeWith: otherSelectionGroupArray [

	currentSelectionGroups == otherSelectionGroupArray ifTrue: [ ^ false ].
	currentSelectionGroups size ~= otherSelectionGroupArray size ifTrue: [ ^ true ].
	currentSelectionGroups withIndexDo: [ :g :idx |
		g = (otherSelectionGroupArray at: idx) ifFalse: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
ToListSelectionElementOption >> triggerSelectionState: aBoolean [

	triggerSelectionState := aBoolean
]

{ #category : #'private - selection updating' }
ToListSelectionElementOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	| newGroups |
	newGroups := self
		             currentSelectionGroupsFrom: aListElement
		             withSelectionModel: aSelectionModel.
	(self selectionGroupsChangeWith: newGroups) ifFalse: [ ^ self ].
	self removeSelectionIn: aListElement.
	currentSelectionGroups := newGroups.
	masked ifTrue: [ ^ self ].
	self addSelectionIn: aListElement.
	self rememberSelectionBoundsIn: aListElement
]
