Class {
	#name : #ToListElement,
	#superclass : #ToElement,
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

{ #category : #testing }
ToListElement >> hasSelection [

	^ self next hasSelection
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

	| updater |
	updater := ToListPrimarySelectionUpdater new.
	updater onInstalledIn: self
]

{ #category : #initialization }
ToListElement >> withoutSelectionDecoration [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new
]
