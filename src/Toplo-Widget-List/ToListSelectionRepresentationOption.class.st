Class {
	#name : #ToListSelectionRepresentationOption,
	#superclass : #Object,
	#instVars : [
		'selectionOption',
		'representation',
		'newRepresentationRequested'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionRepresentationOption class >> embedded [

	^ ToListSelectionWithoutElementOption new
]

{ #category : #'instance creation' }
ToListSelectionRepresentationOption class >> neighbouring [

	^ ToListSelectionWithNeighboringElementOption new
]

{ #category : #'instance creation' }
ToListSelectionRepresentationOption class >> separate [

	^ ToListSelectionWithSeparateElementOption new
]

{ #category : #initialization }
ToListSelectionRepresentationOption >> initialize [ 

	super initialize.
	representation := ToEmptySelectionRepresentation new.
	newRepresentationRequested := true
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isEmbedded [ 

	^ false
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isGrouped [ 

	^ false
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isMasked [

	^ selectionOption isMasked
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isSeparate [

	^ false
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> nextSelectionRepresentationFrom: aListElement withSelectionModel: aSelectionModel [

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

{ #category : #'private - selection updating' }
ToListSelectionRepresentationOption >> notifyNodesDeselectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerElement nodesDo: [ :n |
		n holder notifyDeselectedWithOption: selectionOption ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationOption >> notifyNodesSelectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerElement nodesDo: [ :n |
		n holder notifySelectedWithOption: selectionOption ]
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> refreshSelectionIn: aListElement withSelectionModel: aSelectionModel [

	self
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel
]

{ #category : #removing }
ToListSelectionRepresentationOption >> removeSelectionContainer [
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> requestNewRepresentation [ 

	newRepresentationRequested := true
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> selectionElements [

	^ #(  )
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption 
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> triggerSelectionState [

	^ selectionOption triggerSelectionState
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	| rep |
	rep := self
		       nextSelectionRepresentationFrom: aListElement
		       withSelectionModel: aSelectionModel.
	newRepresentationRequested ifFalse: [
		rep = representation ifTrue: [ ^ false ] ].
	representation onRemovedFromListElement: aListElement.
	" send deselected when selection element are removed to send DeselectedSkinEvent to nodes "
	self notifyNodesDeselectedIn: aListElement.
	representation := rep.
	newRepresentationRequested := false.
	^ true
]
