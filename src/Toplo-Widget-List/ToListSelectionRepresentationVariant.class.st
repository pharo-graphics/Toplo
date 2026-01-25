Class {
	#name : #ToListSelectionRepresentationVariant,
	#superclass : #Object,
	#instVars : [
		'selectionOption',
		'representationChanged',
		'newRepresentationRequested',
		'representation'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionRepresentationVariant class >> embedded [

	^ ToListSelectionWithoutElementVariant new
]

{ #category : #'instance creation' }
ToListSelectionRepresentationVariant class >> neighbouring [

	^ ToListSelectionWithNeighboringElementVariant new
]

{ #category : #'instance creation' }
ToListSelectionRepresentationVariant class >> separate [

	^ ToListSelectionWithSeparateElementVariant new
]

{ #category : #initialization }
ToListSelectionRepresentationVariant >> initialize [ 

	super initialize.
	representationChanged := true.
	representation := ToEmptySelectionRepresentation new.
	newRepresentationRequested := true.
]

{ #category : #testing }
ToListSelectionRepresentationVariant >> isEmbedded [ 

	^ false
]

{ #category : #testing }
ToListSelectionRepresentationVariant >> isGrouped [ 

	^ false
]

{ #category : #testing }
ToListSelectionRepresentationVariant >> isMasked [

	^ selectionOption isMasked
]

{ #category : #testing }
ToListSelectionRepresentationVariant >> isSeparate [

	^ false
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> nextRepresentationIn: aListElement withSelectionModel: aSelectionModel [

	| arr |
	arr := self
		       newSelectionRepresentationArrayFrom: aListElement
		       withSelectionModel: aSelectionModel.
	^ arr ifEmpty: [ ToEmptySelectionRepresentation new ] ifNotEmpty: [
			  arr size > 1
				  ifTrue: [
						  ToCompositeSelectionRepresentation new
							  representations: arr;
							  yourself ]
				  ifFalse: [ arr first ] ]
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodesDeselectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement nodeContainersDo: [ :container |
		container holder notifyDeselectedWithOption: selectionOption ]
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodesSelectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement nodeContainersDo: [ :container |
		container holder notifySelectedWithOption: selectionOption ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> removeAllSelectionElements [

	self selectionContainer removeAllSelectionElements

]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> requestNewRepresentation [ 

	newRepresentationRequested := true
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> selectedNodeContainersFrom: aListElement withSelectionModel: aSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListSelectionRepresentationVariant >> selectionContainer [

	^ selectionOption selectionContainer

]

{ #category : #accessing }
ToListSelectionRepresentationVariant >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption 
]

{ #category : #accessing }
ToListSelectionRepresentationVariant >> triggerSelectionState [

	^ selectionOption triggerSelectionState
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	self updateSelectionRepresentationIn: aListElement withSelectionModel: aSelectionModel
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> updateSelectionRepresentationIn: aListElement withSelectionModel: aSelectionModel [

	| nextRepresentation |
	nextRepresentation := self
		       nextRepresentationIn: aListElement
		       withSelectionModel: aSelectionModel.
	" in case of scrolling, one have to force a selection representation 
	change even the selection is not changed "
	newRepresentationRequested ifFalse: [
			(nextRepresentation equivalentTo: representation) ifTrue: [
					representationChanged := false.
					^ self ] ].
	" send deselected when selection element are removed to send DeselectedSkinEvent to nodes "
	self notifyNodesDeselectedIn: aListElement.
	self removeAllSelectionElements.
	representation := nextRepresentation.
	representationChanged := true.
	newRepresentationRequested := false
]
