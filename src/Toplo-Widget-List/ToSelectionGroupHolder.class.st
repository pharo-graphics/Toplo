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
ToSelectionGroupHolder >> animateSelectionUpdate: aSelElement [

	| targetBounds anim |
	targetBounds := aSelElement boundsFromNodes.
	aSelElement position: previousSelectionBounds origin.
	aSelElement size: previousSelectionBounds extent.
	anim := ToBoundsTransition new
		        from: previousSelectionBounds;
		        to: targetBounds;
		        duration: aSelElement option animationDuration;
		        onStepDo: [ :anArray :target |
			        aSelElement position: anArray origin.
			        aSelElement size: anArray extent ].
	anim onFinishedDo: [
		aSelElement position: targetBounds position.
		aSelElement size: targetBounds extent ].
	aSelElement addAnimation: anim.
	aSelElement updateListElement
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdate [
	" a selection transition animation can occur only from one node to one another node.
	- the animation is not possible in case of several selected nodes
	- the animate option must be on  "


	^ previousSelectionBounds notNil
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> canAnimateSelectionUpdateWith: aSelectionElementArray [
	" a selection transition animation can occur only from one node to one another node.
	- the animation is not possible in case of several selected nodes
	- the animate option must be on  "

	previousSelectionBounds ifNil: [ ^ false ].
	aSelectionElementArray size = 1 ifFalse: [ ^ false].
	option animate ifFalse: [ ^ false ].

	^ true
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> checkSelectionFrom: aListElement [

	| currentGroups |
	currentGroups := Array streamContents: [ :stream |
		                 option nextPutSelectionGroupsFrom: aListElement in: stream ].
	(currentGroups size = groups size and: [
		 currentGroups allSatisfy: [ :grp | groups includes: grp ] ])
		ifTrue: [ ^ self ].
	groups do: [ :grp | grp removeSelectionElement ].
	groups := currentGroups
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> collectSelectionElementsFrom: aListElement [

	^ groups collect: [ :grp | grp selectionElementFrom: aListElement ]
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
ToSelectionGroupHolder >> rememberStateWith: aCollectionOfSelectionElements [

	previousSelectionBounds := aCollectionOfSelectionElements first boundsFromNodes merge:
		                           aCollectionOfSelectionElements last boundsFromNodes
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionElements: aSelectionElementArray [

	| first |
	aSelectionElementArray ifEmpty: [ ^ self ].
	'(self canAnimateSelectionUpdateWith: aSelectionElementArray)'.
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
			computeBounds;
			updateListElement ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionFrom: aListElement [

	| selElements |
	self checkSelectionFrom: aListElement.
	selElements := self collectSelectionElementsFrom: aListElement.
	self updateSelectionElements: selElements.
	selElements ifEmpty: [
		self forgetPreviousState.
		^ self ].
	self rememberStateWith: selElements
]
