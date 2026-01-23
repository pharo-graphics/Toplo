Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'selectionMode',
		'masked',
		'triggerSelectionState',
		'animationDuration',
		'beneath',
		'elementFactory',
		'selectionContainer',
		'representationVariant'
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
	masked := false.
	triggerSelectionState := false.
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
ToListSelectionOption >> isSeparate [

	^ self isGrouped not
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

	selectionContainer := self newSelectionContainerIn: aListElement.
	selectionContainer beneath: beneath.
	aListElement addChild: selectionContainer
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onUninstalledIn: aListElement [

	selectionContainer removeFromParent.
	
]

{ #category : #accessing }
ToListSelectionOption >> representationVariant: aRepresentationVariant [

	representationVariant := aRepresentationVariant.
	aRepresentationVariant selectionOption: self
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> requestNewRepresentation [

	representationVariant requestNewRepresentation
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer [

	^ selectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> selectionElements [

	^ selectionContainer children asArray
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
ToListSelectionOption >> triggerSelectionState [

	^ triggerSelectionState
]

{ #category : #accessing }
ToListSelectionOption >> triggerSelectionState: aBoolean [

	triggerSelectionState := aBoolean
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	representationVariant
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel.
	selectionMode dirty: false
]

{ #category : #accessing }
ToListSelectionOption >> withEmbeddedRepresentation [

	self representationVariant: ToListSelectionRepresentationVariant embedded
]
