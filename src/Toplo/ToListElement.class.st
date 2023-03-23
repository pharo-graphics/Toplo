Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'selectionDecorationUpdater'
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
	self withSelectionDecoration.
	self initializeDresser 
]

{ #category : #accessing }
ToListElement >> withSelectionDecoration [

	selectionDecorationUpdater ifNil: [
		selectionDecorationUpdater := ToListSelectionDecorationUpdater new.
		selectionDecorationUpdater onInstalledIn: self ]
]

{ #category : #accessing }
ToListElement >> withoutSelectionDecoration [

	selectionDecorationUpdater ifNotNil: [
		selectionDecorationUpdater onUninstalledIn: self.
		selectionDecorationUpdater := nil ]
]
