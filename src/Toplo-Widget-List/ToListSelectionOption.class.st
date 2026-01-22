Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'selectionMode',
		'masked',
		'triggerSelectionState',
		'representationOption',
		'animationDuration',
		'beneath',
		'elementFactory',
		'selectionContainer'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToListSelectionOption >> addAllSelectionElements: aSelectionElementArray [

	self isMasked ifTrue: [ ^ self ].
	selectionContainer addChildren: aSelectionElementArray
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> addSelectionElement: aSelectionElement [

	self isMasked ifTrue: [ ^ self ].
	selectionContainer addChild: aSelectionElement
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
		       ifTrue: [ ToListSelectionRepresentationOption neighbouring ]
		       ifFalse: [ ToListSelectionRepresentationOption separate ].
	self representation: opt
]

{ #category : #testing }
ToListSelectionOption >> hasEmbeddedRepresentation [

	^ representationOption isEmbedded 
]

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	masked := false.
	triggerSelectionState := false.
	animationDuration := 0 milliSecond.
	beneath := true.
	self representation: ToListSelectionRepresentationOption separate
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

	^ representationOption isGrouped
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

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionElementIn: aListElement [

	^ representationOption newSelectionElementIn: aListElement
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> notifyNodesDeselectedIn: aListElement [

	representationOption notifyNodesDeselectedIn: aListElement
]

{ #category : #'private - selection updating' }
ToListSelectionOption >> notifyNodesSelectedIn: aListElement [

	representationOption notifyNodesSelectedIn: aListElement
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
ToListSelectionOption >> representation: aRepresentationOption [

	representationOption := aRepresentationOption.
	aRepresentationOption selectionOption: self
]

{ #category : #accessing }
ToListSelectionOption >> requestNewRepresentation [

	representationOption requestNewRepresentation
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer [

	^ selectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> selectionElements [

	^ representationOption selectionElements
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

	representationOption
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel.
	selectionMode dirty: false
]

{ #category : #accessing }
ToListSelectionOption >> withEmbeddedRepresentation [

	self representation: ToListSelectionRepresentationOption embedded
]
