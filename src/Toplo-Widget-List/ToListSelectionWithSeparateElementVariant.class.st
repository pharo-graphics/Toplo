Class {
	#name : #ToListSelectionWithSeparateElementVariant,
	#superclass : #ToListSelectionWithElementVariant,
	#instVars : [
		'previousSelectionBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #adding }
ToListSelectionWithSeparateElementVariant >> addSelectionElements: anArray withAnimationIn: aListElement [
	" add new selection with animation if possible. 
	Pay attention, an animation can be used. In case of animation, the SelectedSkinEvent is sent only when the animation ends to have a nice visual effect. If no animation is used, then SelectedSkinEvent is sent just after the selection element is added "

	| finalBounds startBounds anim |
	self isMasked ifTrue: [ ^ self ].
	anArray isEmpty ifTrue: [ ^ self ].
	finalBounds := Rectangle merging: (anArray collect: [ :g |
			                g precomputedBoundsIn: aListElement ]).
	startBounds := previousSelectionBounds.
	anim := self
		        animationFrom: startBounds
		        to: finalBounds
		        forSelectionElement: anArray first
		        in: aListElement.

	anArray first addAnimation: anim.
	anArray first requestLayout.
	self selectionContainer addChildren: anArray.
	previousSelectionBounds := finalBounds
]

{ #category : #'private - selection updating' }
ToListSelectionWithSeparateElementVariant >> animationFrom: startBounds to: finalBounds forSelectionElement: aSelectionElement in: aListElement [

	aSelectionElement extent: startBounds extent.
	aSelectionElement position: startBounds origin.
	^ ToBoundsTransition new
		  from: startBounds;
		  to: finalBounds;
		  duration: selectionOption animationDuration;
		  onStepDo: [ :aRectangle :target |
				  aSelectionElement extent: aRectangle extent.
				  aSelectionElement position: aRectangle origin ];
		  onFinishedDo: [
				  aSelectionElement position: finalBounds origin.
				  aSelectionElement extent: finalBounds extent.
				  aSelectionElement whenLayoutedDoOnce: [
						  self notifyNodesSelectedIn: aListElement ] ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithSeparateElementVariant >> canAnimateSelectionUpdateIn: aListElement [

	^ self isAnimated and: [
			  representation isComposite not and: [
				  aListElement useCheckbox not and: [
					  previousSelectionBounds notNil ] ] ]
]

{ #category : #adding }
ToListSelectionWithSeparateElementVariant >> checkPreviousSelectionBoundsWith: anArray in: aListElement [

	previousSelectionBounds ifNil: [
			previousSelectionBounds := Rectangle merging:
				                           (anArray collect: [ :g |
					                            g precomputedBoundsIn: aListElement ]) ]
]

{ #category : #testing }
ToListSelectionWithSeparateElementVariant >> isSeparate [

	^ true
]

{ #category : #'private - selection updating' }
ToListSelectionWithSeparateElementVariant >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement nodeContainersSelect: [ :container |
		   | idx |
		   idx := container holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :container |
		  ToSeparateSelection new
			  node: container;
			  yourself ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithSeparateElementVariant >> updateSelectionContainerWith: anArray in: aListElement [
	" add new selection with animation if possible. 
	"
	(self canAnimateSelectionUpdateIn: aListElement)
		ifTrue: [
		self addSelectionElements: anArray withAnimationIn: aListElement ]
		ifFalse: [
		super updateSelectionContainerWith: anArray in: aListElement ].
	self checkPreviousSelectionBoundsWith: anArray in: aListElement
]
