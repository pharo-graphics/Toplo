Class {
	#name : #ToListElement,
	#superclass : #ToPane,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - initialization dresser' }
ToListElement >> defaultDresser [ 

	^ ToListElementDresser new
]

{ #category : #initialization }
ToListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListElement >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self next: ToListInfiniteElement new.
	self next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self addChild: next.
	self matchParent.
	self withSelectionDecoration.
	self initializeDresser 
]

{ #category : #initialization }
ToListElement >> withSelectionDecoration [

	self withSelectionDecorationUpdater: ToListPrimarySelectionUpdater new
]

{ #category : #initialization }
ToListElement >> withSelectionDecorationFactory: aValuable [

	self withSelectionDecorationUpdater: (ToListPrimarySelectionUpdater new decorationFactory: aValuable)
]

{ #category : #'private-initialization' }
ToListElement >> withSelectionDecorationUpdater: aSelectionUpdater [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new.
	aSelectionUpdater onInstalledIn: self
]

{ #category : #initialization }
ToListElement >> withoutSelectionDecoration [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new
]
