Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'selectionUpdater'
	],
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
	selectionUpdater := ToListSelectionDecorationUpdater new.
	selectionUpdater onInstalledIn: self.
	self initializeDresser 
]

{ #category : #'infinite element changes' }
ToListElement >> updateSelectionBackground: aBackground [

	selectionUpdater updateSelectionBackground: aBackground
]
