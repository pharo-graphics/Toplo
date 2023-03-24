Class {
	#name : #ToListPrimarySelectionElement,
	#superclass : #ToListNodesDecorationElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListPrimarySelectionElement >> actualBackgroundColor [

	^ self listElement infinite isFocused
		  ifTrue: [ self theme item selectedColor ]
		  ifFalse: [ self theme item selectedBlurredColor ]
]

{ #category : #'change reporting' }
ToListPrimarySelectionElement >> backgroundChanged [ 

	listElement ifNil: [ ^ self ].
	self nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationChangedEvent new decoration: self; yourself) ].

]

{ #category : #'change reporting' }
ToListPrimarySelectionElement >> beWithSecondarySelection [

	self padding: (BlInsets all: 3)
]

{ #category : #'change reporting' }
ToListPrimarySelectionElement >> beWithoutSecondarySelection [

	self padding: self defaultPadding
]

{ #category : #initialization }
ToListPrimarySelectionElement >> initialize [ 

	super initialize.
	self padding: self defaultPadding.
	back := ToElement new matchParent.
	back geometry: self defaultGeometry.
	back when: BlElementBackgroundChangedEvent do: [ self backgroundChanged ].
	self addChild: back.
]

{ #category : #accessing }
ToListPrimarySelectionElement >> listElement: aListElement [

	super listElement: aListElement.
	aListElement infinite when: BlBlurEvent do: [ :anEvent | back background: self actualBackgroundColor ].
	aListElement infinite when: BlFocusEvent do: [ :anEvent | back background: self actualBackgroundColor ]
]

{ #category : #'hooks - children' }
ToListPrimarySelectionElement >> onAddedToParent [ 

	self background: Color white.
	back background: self actualBackgroundColor.
	self nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationAddedEvent new decoration: self; yourself) ].
	super onAddedToParent 
]

{ #category : #'hooks - children' }
ToListPrimarySelectionElement >> onRemovedFromParent: aParentElement [

	super onRemovedFromParent: aParentElement.
	self nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationRemovedEvent new decoration: self; yourself) ].

	

]
