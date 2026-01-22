Class {
	#name : #ToListSelectionWithElementOption,
	#superclass : #ToListSelectionRepresentationOption,
	#instVars : [
		'previousSelectionBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToListSelectionWithElementOption >> addSelectionElementsIn: aListElement startingAt: aPosition [

	| elements |
	elements := representation selectionElements.
	aPosition > 1 ifTrue: [
		elements := elements copyFrom: aPosition to: elements size ].
	selectionOption addAllSelectionElements: elements
]

{ #category : #adding }
ToListSelectionWithElementOption >> addSelectionIn: aListElement [
	" add new selection with animation if possible. 
	Pay attention, an animation can be used. In case of animation, the SelectedSkinEvent is sent only
	when the animation ends to have a nice visual effect. If no animation is used, then SelectedSkinEvent is
	sent just after the selection is added "

	| finalBounds startBounds |

	representation isEmpty ifTrue: [ ^ self ].
	representation
		refreshSelectionElementIn: aListElement
		option: self.

	" animation is used if the start and the final bounds differs and in case of one selection group only "
	self canAnimateSelectionUpdate ifFalse: [
		self addSelectionElementsIn: aListElement startingAt: 1.
		self notifyNodesSelectedIn: aListElement.
		^ self ].

	startBounds := previousSelectionBounds.
	finalBounds := representation selectionBounds.

	self
		boundsAnimationFrom: startBounds
		to: finalBounds
		onRepresentation: representation
		in: aListElement.

	" add others "
	self addSelectionElementsIn: aListElement startingAt: 2
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> boundsAnimationFrom: startBounds to: finalBounds onRepresentation: aRepresentation in: aListElement [

	| theSelectionElement anim |
	theSelectionElement := aRepresentation selectionElement.
	theSelectionElement extent: startBounds extent.
	theSelectionElement position: startBounds origin.
	selectionOption addSelectionElement: theSelectionElement.
	anim := ToBoundsTransition new
		        from: startBounds;
		        to: finalBounds;
		        duration: selectionOption animationDuration;
		        onStepDo: [ :aRectangle :target |
				        theSelectionElement extent: aRectangle extent.
				        theSelectionElement position: aRectangle origin ];
		        onFinishedDo: [
				        theSelectionElement position: finalBounds origin.
				        theSelectionElement extent: finalBounds extent.
				        theSelectionElement whenLayoutedDoOnce: [
						        self notifyNodesSelectedIn: aListElement ] ].
	theSelectionElement addAnimation: anim
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> canAnimateSelectionUpdate [

	^ self isAnimated and: [
		  representation isComposite not and: [
			  previousSelectionBounds notNil ] ]
]

{ #category : #testing }
ToListSelectionWithElementOption >> isAnimated [

	^ selectionOption isAnimated 
]

{ #category : #accessing }
ToListSelectionWithElementOption >> isBeneath [

	^ selectionOption isBeneath 
]

{ #category : #'private - selection updating' }
ToListSelectionWithElementOption >> newSelectionElementIn: aListElement [

	^ selectionOption elementFactory value
		  listElement: aListElement;
		  selectionOption: self;
		  yourself
]

{ #category : #'nodes collecting' }
ToListSelectionWithElementOption >> rememberSelectionBoundsIn: aListElement [

	previousSelectionBounds := representation selectionBounds
]

{ #category : #accessing }
ToListSelectionWithElementOption >> selectionElements [

	^ representation selectionElements
]

{ #category : #'nodes collecting' }
ToListSelectionWithElementOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	(super
		 updateSelectionIn: aListElement
		 withSelectionModel: aSelectionModel) ifFalse: [ ^ false ].

	self addSelectionIn: aListElement.
	self rememberSelectionBoundsIn: aListElement.
	^ true
]
