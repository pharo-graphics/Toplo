Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'selectionUpdater',
		'selectedItemBackgroundColor',
		'selectedItemBlurredBackgroundColor'
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

{ #category : #accessing }
ToListElement >> selectedItemBackgroundColor [

	^  selectedItemBackgroundColor ifNil: [ super selectedItemBackgroundColor ]
]

{ #category : #accessing }
ToListElement >> selectedItemBackgroundColor: aColor [

	selectedItemBackgroundColor := aColor
]

{ #category : #accessing }
ToListElement >> selectedItemBlurredBackgroundColor [

	^  selectedItemBlurredBackgroundColor ifNil: [ super selectedItemBlurredBackgroundColor ]
]

{ #category : #accessing }
ToListElement >> selectedItemBlurredBackgroundColor: aColor [

	selectedItemBlurredBackgroundColor := aColor
]

{ #category : #'infinite element changes' }
ToListElement >> updateSelectionBackground: aBackground [

	selectionUpdater updateSelectionBackground: aBackground
]

{ #category : #accessing }
ToListElement >> withoutSelectionBackground [

	self selectedItemBackgroundColor: Color transparent.
	self selectedItemBlurredBackgroundColor: Color transparent.
	selectionUpdater updateDecorationsIn: self
]
