Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'primarySelectionDecorationUpdater'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListElement >> decorationOn: aNode [

	^ primarySelectionDecorationUpdater decorationOn: aNode
]

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

{ #category : #accessing }
ToListElement >> primarySelectionDecorations [

	^ primarySelectionDecorationUpdater decorations
]

{ #category : #accessing }
ToListElement >> updateSelectionDecoration [

	primarySelectionDecorationUpdater selectionChangedIn: self
]

{ #category : #accessing }
ToListElement >> withSelectionDecoration [

	primarySelectionDecorationUpdater ifNil: [
		primarySelectionDecorationUpdater := ToListPrimarySelectionUpdater new.
		primarySelectionDecorationUpdater onInstalledIn: self ]
]

{ #category : #accessing }
ToListElement >> withoutSelectionDecoration [

	primarySelectionDecorationUpdater ifNotNil: [
		primarySelectionDecorationUpdater onUninstalledIn: self.
		primarySelectionDecorationUpdater := nil ]
]
