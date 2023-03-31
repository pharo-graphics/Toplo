Class {
	#name : #ToListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator',
	#classTraits : 'TToListElementDecorator classTrait',
	#instVars : [
		'placeholder'
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
ToListElement >> defaultPlaceholder [

	^ ToLabel new
		  beMultiLine;
		  text: '';
		  foreground: Color lightGray;
		  margin: (BlInsets all: 5);
		  constraintsDo: [ :c |
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  in: [ :lab |
			  lab layout alignCenter.
			  lab innerElement layout alignCenter ];
		  yourself
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
	self placeholder: self defaultPlaceholder.
	self initializeDresser 
]

{ #category : #accessing }
ToListElement >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToListElement >> placeholder: anElement [

	placeholder ifNotNil: [
		placeholder parentDo: [ :p |
			placeholder removeFromParent.
			placeholder := anElement.
			self addChild: placeholder.
			^ self ] ].
	placeholder := anElement
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
