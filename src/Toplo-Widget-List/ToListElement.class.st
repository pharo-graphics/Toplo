Class {
	#name : #ToListElement,
	#superclass : #ToPane,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListElement >> defaultBackground [

	^ BlBackground paint: Color white
]

{ #category : #'t - initialization dresser' }
ToListElement >> defaultDresser [ 

	^ ToListElementDresser new
]

{ #category : #initialization }
ToListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListElement >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListElement >> defaultPadding [

	" Must be 1 to see the focus frame AND to draw selection decoration correctly (not outside infinite bounds)  "
	^ BlInsets all: 1

]

{ #category : #initialization }
ToListElement >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self next elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self matchParent.
	self withSelectionDecoration.
	self background: self defaultBackground.
	self margin: self defaultMargin.
	self padding: self defaultPadding.
]

{ #category : #'t - initialization dresser' }
ToListElement >> preInitializeDresser [ 

	super preInitializeDresser.

	self next: ToListInfiniteElement new.
	self addChild: self next
]

{ #category : #initialization }
ToListElement >> withSelectionDecoration [

	self withSelectionDecorationUpdater: ToListPrimarySelectionUpdater new
]

{ #category : #'private-initialization' }
ToListElement >> withSelectionDecorationFactory: aValuable [

	self withSelectionDecorationUpdater: (ToListPrimarySelectionUpdater new decorationFactory: aValuable)
]

{ #category : #'private-initialization' }
ToListElement >> withSelectionDecorationUpdater: aSelectionUpdater [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new.
	aSelectionUpdater onInstalledIn: self
]

{ #category : #initialization }
ToListElement >> withSelectionDresserFactory: aValuable [
	"aValuable value is a a dresser instance that can be an instance of a subclass of ToListSelectionDresser. "

	self withSelectionDecorationFactory: [ ToListSelectionElement new dresser: aValuable value ]
]

{ #category : #initialization }
ToListElement >> withoutSelectionDecoration [

	self dispatchEvent: ToListSelectionUpdaterStopEvent new
]
