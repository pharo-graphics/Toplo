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

	| first |

	self notifyNodesDeselectedIn: aListElement.
	
	selectionElements ifEmpty: [ ^ self ].

	(self canAnimateSelectionUpdate and: [ selectionElements size = 1 ])
		ifTrue: [
			| targetBounds startBounds |
			first := selectionElements first.
			first position: previousSelectionBounds origin.
			first size: previousSelectionBounds extent.
			startBounds := previousSelectionBounds.
			targetBounds := first boundsFromNodesIn: aListElement.

			animation := ToBoundsTransition new
				             from: startBounds;
				             to: targetBounds;
				             duration: option animationDuration;
				             onStepDo: [ :anArray :target |
					             first position: anArray origin.
					             first size: anArray extent ];
				             onFinishedDo: [
					             first position: targetBounds position.
					             first size: targetBounds extent.
					self notifyNodesSelectedIn: aListElement. ].
			first addAnimation: animation.
			" directly add the selection element without computing its bounds "
			self isBeneath
				ifTrue: [ aListElement addBeneathSelectionElement: first ]
				ifFalse: [ aListElement addOverSelectionElement: first ].
			" add others "
			self addSelectionElementsIn: aListElement startingAt: 2.
			^ self ].
	self addSelectionElementsIn: aListElement startingAt: 1.
	self notifyNodesSelectedIn: aListElement
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
ToSelectionGroupHolder >> forgetPreviousState [

	previousSelectionBounds := nil.
	self removeSelection.
	groups := #(  )
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

	option isPrimary ifTrue: [ aListElement notifyNodesDeselected ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> notifyNodesSelectedIn: aListElement [

	option isPrimary ifTrue: [ aListElement notifyNodesSelected ]
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> notifyNodesSelectionIn: aListElement [

	option isPrimary ifTrue: [ aListElement notifyNodesSelection ]
]

{ #category : #accessing }
ToSelectionGroupHolder >> option: aSelectionOption [

	option := aSelectionOption
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> refreshSelectionIn: aListElement [

	self forgetPreviousState.
	self updateSelectionIn: aListElement
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> rememberStateIn: aListElement [

	previousSelectionBounds := (selectionElements first
		                            boundsFromNodesIn: aListElement) merge:
		                           (selectionElements last
			                            boundsFromNodesIn: aListElement)
]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> removeSelection [

	selectionElements do: [ :s | s removeFromParent ].

]

{ #category : #'private - selection updating' }
ToSelectionGroupHolder >> updateSelectionIn: aListElement [

	| prevGroups |
	prevGroups := groups.
	groups := option collectSelectionGroupsFrom: aListElement.
	(self groups: prevGroups equals: groups) ifTrue: [ ^ self ].
	self removeSelection.
	selectionElements := self collectNewSelectionElementsFrom: aListElement.
	self addSelectionIn: aListElement.
	"self notifyNodesSelectionIn: aListElement."
	selectionElements ifEmpty: [ ^ self ].
	self rememberStateIn: aListElement
]
