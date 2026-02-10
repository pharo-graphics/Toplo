Class {
	#name : #ToListSelectionRepresentationVariant,
	#superclass : #Object,
	#instVars : [
		'selectionOption',
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

{ #category : #accessing }
ToListSelectionRepresentationVariant >> deselectionSkinEventClass [

	^ selectionOption deselectionSkinEventClass
]

{ #category : #initialization }
ToListSelectionRepresentationVariant >> initialize [ 

	super initialize.
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
ToListSelectionRepresentationVariant >> newSelectionRepresentationArrayFrom: aListElement [ 

	^ self subclassResponsibility 
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> nextRepresentationIn: aListElement [

	| arr |
	arr := self
		       newSelectionRepresentationArrayFrom: aListElement.
	^ arr ifEmpty: [ ToEmptySelectionRepresentation new ] ifNotEmpty: [
			  arr size > 1
				  ifTrue: [
						  ToCompositeSelectionRepresentation new
							  representations: arr;
							  yourself ]
				  ifFalse: [ arr first ] ]
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodeContainer: aNodeContainer deselectedIn: aListElement [

	| holder evt |
	self deselectionSkinEventClass ifNil: [ ^ self ].
	holder := aNodeContainer holder.
	" am i in the selection ?"
	(self selectionModel containsIndex: holder position) ifTrue: [
		^ self ].
	" have I already notified a deselection ? "
	(holder canNotifyDeselectionForOption: selectionOption) ifFalse: [
		^ self ].
	evt := self deselectionSkinEventClass new.
	evt focused: aListElement focused.
	evt selectionOption: selectionOption.
	holder notifySelectedSkinEvent: evt
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodeContainer: aNodeContainer selectedIn: aListElement [

	| holder evt |
	self selectionSkinEventClass ifNil: [ ^ self ].
	holder := aNodeContainer holder.
	" am i in the selection ?"
	(self selectionModel containsIndex: holder position) ifFalse: [
		^ self ].
	" have I already notified a deselection ? "
	(holder canNotifySelectionForOption: selectionOption) ifFalse: [
		^ self ].
	evt := self selectionSkinEventClass new.
	evt focused: aListElement focused.
	evt selectionOption: selectionOption.
	holder notifySelectedSkinEvent: evt
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodesDeselectedIn: aListElement [

	aListElement nodeContainersDo: [ :container |
		self notifyNodeContainer: container deselectedIn: aListElement ]
]

{ #category : #'private - selection notification' }
ToListSelectionRepresentationVariant >> notifyNodesSelectedIn: aListElement [

	aListElement nodeContainersDo: [ :container |
		self notifyNodeContainer: container selectedIn: aListElement ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> removeAllSelectionElements [

	self selectionContainer ifNotNil: [ :sc |
		sc removeAllSelectionElements ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> selectedNodeContainersFrom: aListElement [ 

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
ToListSelectionRepresentationVariant >> selectionModel [

	^ self selectionMode selectionModel
]

{ #category : #accessing }
ToListSelectionRepresentationVariant >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption 
]

{ #category : #accessing }
ToListSelectionRepresentationVariant >> selectionSkinEventClass [

	^ selectionOption selectionSkinEventClass
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationVariant >> updateRepresentationIn: aListElement [

	representation := self nextRepresentationIn: aListElement.
	self notifyNodesDeselectedIn: aListElement.
	self removeAllSelectionElements
]
