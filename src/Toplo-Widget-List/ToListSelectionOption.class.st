Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#masked => ObservableSlot',
		'#selectionSkinEventClass => ObservableSlot',
		'#deselectionSkinEventClass => ObservableSlot',
		'#animationDuration',
		'#beneath',
		'#elementFactory',
		'#selectionContainer',
		'#selectionMode',
		'#representationVariant'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToListSelectionOption >> animationDuration [

	^ animationDuration 
]

{ #category : #accessing }
ToListSelectionOption >> animationDuration: aDuration [

	animationDuration := aDuration
]

{ #category : #accessing }
ToListSelectionOption >> beneath: aBoolean [

	beneath := aBoolean.
	selectionContainer ifNil: [ ^ self ].
	selectionContainer beneath: aBoolean
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> checkSelectionContainerIn: aListElement [

	masked ifTrue: [
			^ selectionContainer ifNotNil: [
					  selectionContainer removeFromParent.
					  selectionContainer := nil ] ].
	selectionContainer ifNotNil: [ ^ self ].
	selectionContainer := self newSelectionContainerIn: aListElement.
	selectionContainer beneath: beneath.
	aListElement addChild: selectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> deselectionSkinEventClass [

	^ deselectionSkinEventClass
]

{ #category : #accessing }
ToListSelectionOption >> deselectionSkinEventClass: aSkinEventClass [

	deselectionSkinEventClass := aSkinEventClass
]

{ #category : #accessing }
ToListSelectionOption >> elementFactory [

	^ elementFactory 
]

{ #category : #accessing }
ToListSelectionOption >> elementFactory: aSelectionElementFactoryValuable [

	elementFactory := aSelectionElementFactoryValuable
]

{ #category : #accessing }
ToListSelectionOption >> grouped: aBoolean [

	| opt |
	opt := aBoolean
		       ifTrue: [ ToListSelectionRepresentationVariant neighbouring ]
		       ifFalse: [ ToListSelectionRepresentationVariant separate ].
	self representationVariant: opt
]

{ #category : #testing }
ToListSelectionOption >> hasEmbeddedRepresentation [

	^ representationVariant isEmbedded 
]

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	self class initializeSlots: self.
	masked := true.
	animationDuration := 0 milliSecond.
	beneath := true.
	self representationVariant: ToListSelectionRepresentationVariant separate
]

{ #category : #accessing }
ToListSelectionOption >> isAnimated [

	^  animationDuration asMilliSeconds > 0
]

{ #category : #testing }
ToListSelectionOption >> isBeneath [

	^ beneath 
]

{ #category : #testing }
ToListSelectionOption >> isGrouped [

	^ representationVariant isGrouped
]

{ #category : #testing }
ToListSelectionOption >> isMasked [

	^ masked 
]

{ #category : #testing }
ToListSelectionOption >> isPrimary [

	^ selectionMode isPrimary
]

{ #category : #accessing }
ToListSelectionOption >> masked: aBoolean [

	masked := aBoolean
]

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionContainerIn: aListElement [

	^ selectionMode newSelectionContainerIn: aListElement
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> notifyNodesDeselectedIn: aListElement [

	representationVariant notifyNodesDeselectedIn: aListElement
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> notifyNodesSelectedIn: aListElement [

	representationVariant notifyNodesSelectedIn: aListElement
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onInstalledIn: aListElement [

	self property: #masked whenChangedDo: [
			self checkSelectionContainerIn: aListElement.
			self updateRepresentationIn: aListElement ].
	self
		property: #selectionSkinEventClass
		whenChangedDo: [ self updateRepresentationIn: aListElement ].
	self
		property: #deselectionSkinEventClass
		whenChangedDo: [ self updateRepresentationIn: aListElement ].

	self checkSelectionContainerIn: aListElement
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onUninstalledIn: aListElement [

	selectionContainer ifNotNil: [ :sc | sc removeFromParent ].
	
]

{ #category : #accessing }
ToListSelectionOption >> representationVariant: aRepresentationVariant [

	representationVariant := aRepresentationVariant.
	aRepresentationVariant selectionOption: self
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer [

	^ selectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> selectionElements [

	^ selectionContainer
		  ifNil: [ #(  ) ]
		  ifNotNil: [ :sc | sc children asArray ]
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode: aListSelectionMode [

	selectionMode := aListSelectionMode
]

{ #category : #accessing }
ToListSelectionOption >> selectionSkinEventClass [

	^ selectionSkinEventClass
]

{ #category : #accessing }
ToListSelectionOption >> selectionSkinEventClass: aSkinEventClass [

	selectionSkinEventClass := aSkinEventClass
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> updateRepresentationIn: aListElement [

	representationVariant updateRepresentationIn: aListElement.
	selectionMode dirty: false
]

{ #category : #accessing }
ToListSelectionOption >> withEmbeddedRepresentation [

	self representationVariant: ToListSelectionRepresentationVariant embedded
]
