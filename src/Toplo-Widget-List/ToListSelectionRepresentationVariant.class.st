Class {
	#name : #ToListSelectionRepresentationVariant,
	#superclass : #Object,
	#instVars : [
		'selectionOption',
		'representationChanged',
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

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> checkRepresentationIn: aListElement withSelectionModel: aSelectionModel forceUpdate: aBoolean [

	| nextRepresentation |
	nextRepresentation := self
		                      nextRepresentationIn: aListElement
		                      withSelectionModel: aSelectionModel.
	representationChanged := aBoolean
		                         ifTrue: [ true ]
		                         ifFalse: [
		                         (nextRepresentation equivalentTo:
			                          representation) not ].
	representationChanged ifFalse: [ ^ self ].
	representation := nextRepresentation.
	self notifyNodesDeselectedIn: aListElement.
	self removeAllSelectionElements
]

{ #category : #initialization }
ToListSelectionRepresentationVariant >> initialize [ 

	super initialize.
	representationChanged := true.
	representation := ToEmptySelectionRepresentation new
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

	self selectionMode isPrimary ifFalse: [ ^ self ].
	aListElement nodeContainersDo: [ :container |
		container holder notifyDeselectedWithOption: selectionOption ]
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodesSelectedIn: aListElement [

	self selectionMode isPrimary ifFalse: [ ^ self ].
	aListElement nodeContainersDo: [ :container |
		container holder notifySelectedWithOption: selectionOption ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> removeAllSelectionElements [

	self selectionContainer ifNotNil: [ :sc |
		sc removeAllSelectionElements ]
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
ToListSelectionRepresentationVariant >> selectionMode [ 

	^ selectionOption selectionMode
]

{ #category : #accessing }
ToListSelectionRepresentationVariant >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption 
]
