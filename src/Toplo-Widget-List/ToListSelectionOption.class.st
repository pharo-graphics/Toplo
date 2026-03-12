Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#selectionSkinEventClass => ObservableSlot',
		'#deselectionSkinEventClass => ObservableSlot',
		'#representationVariant => ObservableSlot',
		'#animationDuration',
		'#beneath',
		'#elementFactory',
		'#selectionContainer',
		'#selectionMode',
		'#updatePostponed'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToListSelectionOption >> addSelectionContainerIn: aListElement [

	selectionContainer ifNotNil: [ ^ self ].
	selectionContainer := self newSelectionContainerIn: aListElement.
	selectionContainer beneath: beneath.
	aListElement addChild: selectionContainer
]

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

{ #category : #accessing }
ToListSelectionOption >> checkRepresentationVariantin: aListElement [

	representationVariant selectionOption: self.
	self checkSelectionContainerIn: aListElement.
	updatePostponed ifTrue: [ ^ self ].
	updatePostponed := true.
	aListElement postponeAction: [
		updatePostponed := false.
		self updateRepresentationIn: aListElement ]
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> checkSelectionContainerIn: aListElement [

	representationVariant checkSelectionContainerIn: aListElement
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
	animationDuration := 0 milliSecond.
	beneath := true.
	updatePostponed := false.
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
ToListSelectionOption >> isPrimary [

	^ selectionMode isPrimary
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

   "	(aListElement isKindOf: ToMenuItemListElement) 
		ifFalse: [self isPrimary 
			ifTrue: ['Option>>notifyNodesSelectedIn: '  traceCr ] ]."

	representationVariant notifyNodesSelectedIn: aListElement
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onInstalledIn: aListElement [

	self
		property: #selectionSkinEventClass
		whenChangedDo: [ self updateRepresentationIn: aListElement ].
	self
		property: #deselectionSkinEventClass
		whenChangedDo: [ self updateRepresentationIn: aListElement ].
	self
		property: #representationVariant
		whenChangedDo: [ self checkRepresentationVariantin: aListElement ].

	self checkSelectionContainerIn: aListElement
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onUninstalledIn: aListElement [

	selectionContainer ifNotNil: [ :sc | sc removeFromParent ].
	
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> removeSelectionContainerIn: aListElement [

	selectionContainer ifNil: [ ^ self ].
	selectionContainer removeFromParent.
	selectionContainer := nil
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
